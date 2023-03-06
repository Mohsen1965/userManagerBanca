<?php

namespace App\Form;

use App\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

    class SearchType extends AbstractType
    {
        public function buildForm(FormBuilderInterface $builder, array $options)
        {
            $builder->add('search', SearchType::class, [
                'attr' => [
                    'class' => 'form-control',
                    'placeholder' => 'Search',
                ],
            ]);
        }
    
        public function configureOptions(OptionsResolver $resolver)
        {
            $resolver->setDefaults([
                'csrf_protection' => false,
            ]);
        }
}
