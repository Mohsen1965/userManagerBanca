<?php

namespace App\Controller;

namespace App\Controller;

use App\Entity\Role;
use App\Form\RoleType;
use App\Form\EntityType;
use App\Repository\RoleRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Knp\Component\Pager\PaginatorInterface;
use Knp\Bundle\PaginatorBundle\Pagination\SlidingPaginationInterface;
use Dompdf\Dompdf;

#[Route('/role')]
class RoleController extends AbstractController
{
    #[Route('/', name: 'app_role_index', methods: ['GET'])]
    public function index(RoleRepository $roleRepository, PaginatorInterface $paginator, Request $request): Response
    {


        $roles = $roleRepository->findBy([], ['id' => 'DESC']);

        $roles = $paginator->paginate(
        $roles, /* query NOT result */
        $request->query->getInt('page', 1),
        3
    );
        return $this->render('role/index.html.twig', [
            'roles' => $roles
        ]);
    }

    #[Route('/new', name: 'app_role_new', methods: ['GET', 'POST'])]
    public function new(Request $request, RoleRepository $roleRepository): Response
    {
        $role = new Role();
        $form = $this->createForm(RoleType::class, $role);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $roleRepository->save($role, true);

            return $this->redirectToRoute('app_role_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('role/new.html.twig', [
            'role' => $role,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_role_show', methods: ['GET'])]
    public function show(Role $role): Response
    {
        return $this->render('role/show.html.twig', [
            'role' => $role,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_role_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Role $role, RoleRepository $roleRepository): Response
    {
        $form = $this->createForm(RoleType::class, $role);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $roleRepository->save($role, true);

            return $this->redirectToRoute('app_role_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('role/edit.html.twig', [
            'role' => $role,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_role_delete', methods: ['POST'])]
    public function delete(Request $request, Role $role, RoleRepository $roleRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$role->getId(), $request->request->get('_token'))) {
            $roleRepository->remove($role, true);
        }

        return $this->redirectToRoute('app_role_index', [], Response::HTTP_SEE_OTHER);
    }
    
    public function __toString()
{
    return $this->nom;
}

/**
     * @Route("/search", name="app_role_search")
     */
//#[Route('/search', name: 'app_role_search')]
public function searchRole(Request $request, RoleRepository $roleRepository)
{
    $searchTerm = $request->query->get('query');
    $roles = $roleRepository->findBy(['nom' => $searchTerm]);

    return $this->render('role/index.html.twig', [
        'roles' => $roles,
    ]);
}








/**
     * @Route("/role/pdf", name="role_pdf")
     */
public function generateRolePdf(RoleRepository $roleRepository, Request $request): Response
    {
        $query = $request->query->get('query');
        $roles = $roleRepository->findOneBySomeNom($query);
    
        // Render the view for the searched list of users
        $html = $this->renderView('role/role_list.html.twig', [
            'roles' => $roles
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
    
    
    


