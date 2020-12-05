<?php namespace App\Controllers;

use CodeIgniter\Config\Services;
use CodeIgniter\RESTful\ResourceController;

class Category extends ResourceController{
    protected $modelName = 'App\Models\Category_model';
    protected $format = 'json';
    function index()
    {
        return $this->respond($this->model->findAll(),200);
    }
    public function create()
    {
        $data=[
            'category'=>$this->request->getPost('category')
        ];
        $validation=Services::validation();
    if($validation->run($data,'category')==FALSE){
        $response = [
            'status' => 500,
            'error' => true,
            'data' => $validation->getErrors(),
        ];
        return $this->respond($response, 500);
    }else {
        $simpan = $this->model->addKategori($data);
    
        if($simpan){
            $msg = ['message' => 'Add category successfully'];
            $response = [
                'status' => 200,
                'error' => false,
                'data' => $msg,
            ];
            return $this->respond($response, 200);
        }
    }
        
    }
    public function update($id=NULL)
    {
        $data=[
            'category'=>$this->request->getPost('category')
        ];
        $validation=Services::validation();
    if($validation->run($data,'category')==FALSE){
        $response = [
            'status' => 500,
            'error' => true, 
            'data' => $validation->getErrors(),
        ];
        return $this->respond($response, 500);
    }else {
        $simpan = $this->model->updateKategori($data,$id);
        if($simpan){
            $msg = ['message' => 'Update category  successfully'];
            $response = [
                'status' => 200,
                'error' => false,
                'data' => $msg,
            ];
            return $this->respond($response, 200);
        }
    }
    }
}