<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;

class Auth extends ResourceController
{
    protected $format = 'json';
    protected $modelName = 'App\Models\Auth_model';

    public function login()
    {
        $email = $this->request->getPost('email');
        $password = $this->request->getPost('password');

        $data = [
            'email' => $email,
            'password' => $password
        ];

        $result = $this->model->login($email, $password);
        $response = [
            'status' => 200,
            'error' => false,
            'data' => $result,
        ];
        return $this->respond($response, 200);
    }
    public function register()
    {
        $email = $this->request->getPost('email');
        $password = $this->request->getPost('password');
        $fullname = $this->request->getPost('fullname');
        $data = [
            'email' => $email,
            'password' => $password
        ];
        $result = $this->model->register($email, $password);
        $response = [
            'status' => 200,
            'error' => false,
            'data' => $result,
        ];
        return $this->respond($response, 200);
    }
}
