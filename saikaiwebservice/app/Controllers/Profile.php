<?php 
namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;
use EmptyIterator;

class Profile extends ResourceController{
    
    protected $modelName="App\Models\Profile_model";
    protected $format="json";
    public function profile($id){
        $default=Array(''=>'');
        $data =$this->model->getProfile($id)??$default;
      return $this->respond($data);
    }
    public function update($id=NULL){
        $nama=$this->request->getPost('nama');
        $phone=$this->request->getPost('phone');
        $pekerjaan=$this->request->getPost('pekerjaan');

        $data=[];

        if($nama!==NULL)$data['nama']=$nama;
        if($phone!==NULL) $data['phone']=$phone;
        if($pekerjaan!==NULL) $data['pekerjaan']=$pekerjaan;
        if($data!==[])
        if($this->model->updateProfile($id,$data)){
            $response = [
                'status' => 200,
                'error' => false,
                'data' => ['message'=>'update profil berhasil'],
            ];
            return $this->respond($response,200);
        }else{
            $response = [
                'status' => 500,
                'error' => true,
                'data' =>['message'=>'update profil gagal'],
            ];
            return $this->respond($response,500);
        }
        else
            $response = [
                'status' => 500,
                'error' => true,
                'data' =>['message'=>'data profil tidak boleh kosong'],
            ];
            return $this->respond($response,500);
        
    }
}