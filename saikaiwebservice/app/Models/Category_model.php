<?php namespace App\Models;

use CodeIgniter\Model;

class Category_model extends Model{
    protected $table='Category';
    public function getKategori()
    {
        return $this->findAll();
    }
    public function addKategori($kategori)
    {
        return $this->db->table($this->table)->insert($kategori);
    }
    public function updateKategori($kategori,$id)
    {
        return $this->db->table($this->table)->update($kategori,["id_kategori"=>$id]);
    }
    public function deleteKategori($id){
        return $this->db->table($this->table)->delete(["id_kategori"=>$id]);
    }
    
}