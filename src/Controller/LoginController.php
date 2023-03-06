<?php


namespace App\Controller;

use App\Form\LoginFormType;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class LoginController extends AbstractController
{
    /**
     * @Route("/login", name="app_login")
     */
    public function login(Request $request, AuthenticationUtils $authenticationUtils)
    {
        // If the user is already authenticated, redirect to the dashboard.
        if ($this->getUser()) {
            return $this->redirectToRoute('app_dashboard');
        }

        // Create the login form.
        $form = $this->createForm(LoginFormType::class);

        // Handle the login form submission.
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            // Get the email and password from the form.
            $credentials = $form->getData();

            // Authenticate the user.
            $user = $this->getDoctrine()->getRepository(User::class)->findOneBy(['username' => $credentials['username']]);
            if (!$user) {
                $this->addFlash('error', 'Invalid username or password.');

                return $this->redirectToRoute('app_login');
            }

            if (!$encoder->isPasswordValid($user, $credentials['password'])) {
                $this->addFlash('error', 'Invalid username or password.');

                return $this->redirectToRoute('app_login');
            }

            // If the user is authenticated, redirect to the dashboard.
            return $this->redirectToRoute('app_dashboard');
        }

        // Render the login form.
        return $this->render('login.html.twig', [
            'form' => $form->createView(),
            'error' => $authenticationUtils->getLastAuthenticationError(),
        ]);
    }
    #[Route('/logout', name: 'app_logout')]
public function logout() {}
}
