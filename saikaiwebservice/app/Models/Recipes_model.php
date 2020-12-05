<?php

namespace App\Models;

use CodeIgniter\Model;

class Recipes_model extends Model
{
    protected $table = 'recipes';
    public function addRecipe($recipe)
    {
        return $this->db->table($this->table)->insert($recipe);
    }
    public function updateRecipe($id, $recipe)
    {
        return $this->db->table($this->table)->update($recipe, ["id_recipe" => $id]);
    }
    public function deleteRecipe($id)
    {
        return $this->db->table($this->table)->delete(["id_recipe" => $id]);
    }
}
