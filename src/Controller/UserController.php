<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\UserType;
use App\Form\EntityType;
use App\Repository\UserRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Knp\Component\Pager\PaginatorInterface;
use Knp\Bundle\PaginatorBundle\Pagination\SlidingPaginationInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use Dompdf\Dompdf;

#[Route('/user')]
class UserController extends AbstractController
{

    
    #[Route('/', name: 'app_user_index', methods: ['GET'])]
public function index(UserRepository $userRepository, PaginatorInterface $paginator, Request $request): Response
{
    $users = $userRepository->findBy([], ['created_at' => 'DESC']);

    $users = $paginator->paginate(
        $users, /* query NOT result */
        $request->query->getInt('page', 1),
        3
    );

    return $this->render('user/index.html.twig', [
        'users' => $users,
    ]);
}

    

    #[Route('/new', name: 'app_user_new', methods: ['GET', 'POST'])]
    public function new(Request $request, UserRepository $userRepository): Response
    {
        $user = new User();
        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $userRepository->save($user, true);

            return $this->redirectToRoute('app_user_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('user/new.html.twig', [
            'user' => $user,
            'form' => $form,
        ]);
    }

    /**
 * @Route("/user/{id}", name="app_user_show")
 */

   //#[Route('/{id}', name: 'app_user_show', methods: ['GET'])]
    public function show(User $user): Response
    {
        return $this->render('user/show.html.twig', [
            'user' => $user,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_user_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, User $user, UserRepository $userRepository): Response
    {
        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $userRepository->save($user, true);

            return $this->redirectToRoute('app_user_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('user/edit.html.twig', [
            'user' => $user,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_user_delete', methods: ['POST'])]
    public function delete(Request $request, User $user, UserRepository $userRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$user->getId(), $request->request->get('_token'))) {
            $userRepository->remove($user, true);
        }

        return $this->redirectToRoute('app_user_index', [], Response::HTTP_SEE_OTHER);
    }
    


/**
 * @Route("/user/update-active/{id}", name="update_active", methods={"POST"})
 */
public function update_active(Request $request, UserRepository $userRepository, User $user): Response
{
    $isActive = $request->request->getBoolean('active');
    $user->setIsActive($isActive);

    // Encode the user's password before saving it
    $password = $request->request->get('password');
    if ($password) {
        $encodedPassword = password_hash($password, PASSWORD_DEFAULT);
        $user->setPassword($encodedPassword);
    }

    $userRepository->save($user, true);

    $users = $userRepository->findAll();

    return $this->redirectToRoute('app_user_index', [], Response::HTTP_SEE_OTHER);
}


/**
     * @Route("/search", name="app_user_search", methods={"GET"})
     */

//#[Route('/search', name: 'app_user_search', methods: ['GET'])]
public function findOneBySomeUsername(Request $request, UserRepository $userRepository, PaginatorInterface $paginator): Response
{
    $query = $request->query->get('query');
if (!$query) {
    // handle case where query parameter is missing
}

$sort = $request->query->get('sort', 'username'); // default sort by username
$direction = $request->query->get('direction', 'asc'); // default sort direction is ascending
    
$users = $userRepository->findOneBySomeUsername($query, $sort, $direction);
    
// Paginate the results using the KnpPaginatorBundle
$pagination = $paginator->paginate(
    $users,
    $request->query->getInt('page', 1),
    3 // Items per page
);

return $this->render('user/index.html.twig', [
    'users' => $pagination,
    'sort' => $sort,
    'direction' => $direction, // add the "direction" variable to the view
]);
}



/**
     * @Route("/users/pdf", name="user_pdf")
     */
public function generateUserPdf(UserRepository $userRepository, Request $request): Response
{
    $query = $request->query->get('query');
    $users = $userRepository->findOneBySomeUsername($query);

    // Render the view for the searched list of users
    $html = $this->renderView('user/user_list.html.twig', [
        'users' => $users
    ]);

    // Create a new instance of Dompdf
    $dompdf = new Dompdf();

    // Load the HTML content into Dompdf
    $dompdf->loadHtml($html);

    // Set paper size and orientation
    $dompdf->setPaper('A4', 'portrait');

    // Render the PDF file
    $dompdf->render();

    // Output the generated PDF to the browser
    $response = new Response($dompdf->output());
    $response->headers->set('Content-Type', 'application/pdf');

    // Set the file name
    $response->headers->set('Content-Disposition', 'attachment;filename="user_list.pdf"');

    return $response;
}



}
