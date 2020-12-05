<?php namespace App\Models;

use CodeIgniter\Model;

class Profile_model extends Model{
    protected $table="profile";
    public function getProfile($id_user) 
    {
        return $this->db->table($this->table)->getWhere(["id_user"=>$id_user])->getFirstRow();
    }
    public function updateProfile($id_user,$profile)
    {
        if($this->getProfile($id_user)===NULL){
            $profile['id_user']=$id_user;
           return $this->db->table($this->table)->insert($profile);
        }else{
            return  $this->db->table($this->table)->update($profile,["id_user"=>$id_user]);
        }
    }
}