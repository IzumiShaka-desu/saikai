<?php

namespace App\Controllers;

use CodeIgniter\Config\Services;
use CodeIgniter\RESTful\ResourceController;

class Recipes extends ResourceController
{
  protected $modelName = 'App\Models\Recipes_model';
  protected $format = 'json';
  function index()
  {
    $data= $this->model->findAll()??[];
   
    return $this->respond($data, 200);
  }
  public function create()
  {
    $validation = Services::validation();
    $data = [
      "title" => $this->request->getPost('title'),
      "id_Category" => $this->request->getPost('id_category'),
      "foto" => '-',
      "id_user" => $this->request->getPost('id_user'),
      "date_created" => date('Y-m-d'),
      "servings" => $this->request->getPost('servings'),
      "total_time" => $this->request->getPost('total_time'),
      "ingredients" => $this->request->getPost('ingredients'),
      "steps" => $this->request->getPost('steps'),
    ];
    if ($validation->run($data, 'recipe') == FALSE) {
      $response = [
        'status' => 500,
        'error' => true,
        'data' => $validation->getErrors(),
      ];
      return $this->respond($response, 200);
    } else {
      $image = $this->request->getFile('image');
      $data['foto'] = $image->getRandomName();
      $image->move(ROOTPATH . 'public/images', $data['foto']);
      if ($this->model->addRecipe($data)) {
        $response = [
          'status' => 200,
          'error' => false,
          'data' => ['message' => 'successfull add recipe']
        ];
        return $this->respond($response, 200);
      } else {
        $response = [
          'status' => 500,
          'error' => true,
          'data' => ['message' => 'cannot add recipe']
        ];
        return $this->respond($response, 200);
      }
    }
  }
  public function delete($id = Null)
  {
    if ($id !== Null) {
      if ($this->model->deleteRecipe($id)) {
        $response = [
          'status' => 200,
          'error' => false,
          'data' => ['message' => 'successfull delete recipe']
        ];
        return $this->respond($response, 200);
      } else {
        $response = [
          'status' => 500,
          'error' => true,
          'data' => ['message' => 'cannot delete recipe']
        ];
        return $this->respond($response, 500);
      }
    }
  }
  public function update($id = NULL)
  {
    if ($id !== NULL)
    $data = [
      "title" => $this->request->getPost('title'),
      "id_Category" => $this->request->getPost('id_category'),
      "foto" => $this->request->getPost('foto'),
      "id_user" => $this->request->getPost('id_user'),
      "date_created" => date('Y-m-d'),
      "servings" => $this->request->getPost('servings'),
      "total_time" => $this->request->getPost('total_time'),
      "ingredients" => $this->request->getPost('ingredients'),
      "steps" => $this->request->getPost('steps'),
    ];
   
      if ($this->request->getFile('image') !== NULL) {
        $image = $this->request->getFile('image');

        $image->move(ROOTPATH . 'public/images', $data['foto'], true);
      }
      if ($this->model->updateRecipe($id, $data)) {
        $response = [
          'status' => 200,
          'error' => false,
          'data' => ['message' => 'successfull update recipe']
        ];
        return $this->respond($response, 200);
      } else {
        $response = [
          'status' => 500,
          'error' => true,
          'data' => ['message' => 'cannot update recipe']
        ];
        return $this->respond($response, 500);
      }
    }
  }

