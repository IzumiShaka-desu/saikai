<?php namespace Config;

class Validation
{
	//--------------------------------------------------------------------
	// Setup
	//--------------------------------------------------------------------

	/**
	 * Stores the classes that contain the
	 * rules that are available.
	 *
	 * @var array
	 */
	public $ruleSets = [
		\CodeIgniter\Validation\Rules::class,
		\CodeIgniter\Validation\FormatRules::class,
		\CodeIgniter\Validation\FileRules::class,
		\CodeIgniter\Validation\CreditCardRules::class,
	];

	/**
	 * Specifies the views that are used to display the
	 * errors.
	 *
	 * @var array
	 */
	public $templates = [
		'list'   => 'CodeIgniter\Validation\Views\list',
		'single' => 'CodeIgniter\Validation\Views\single',
	];
	public  $auth=[
		'email'=>'required',
		'password'=>'required'
	];
	public $auth_errors=[
		'email'=>'email wajib diisi',
		'password'=>'password perlu diisi'
	];
	public  $category=[
		'category'=>'required'
	];
	public $category_errors=[
		'category'=>'Nama kategori wajib diisi'
	];
	public $recipe=[
		"title" =>'required',
		"id_Category" => 'required',
		"foto" => 'required',
		"id_user" => 'required',
		"date_created" => 'required',
		"servings" => 'required',
		"total_time" => 'required',
		"ingredients" => 'required',
		"steps" => 'required',
		
	];
	public $recipe_errors=[
		"title" =>'required',
		"id_Category" => 'required',
		"foto" => 'required',
		"id_user" => 'required',
		"date_created" => 'required',
		"servings" => 'required',
		"total_time" => 'required',
		"ingredients" => 'required',
		"steps" => 'required',
		
	];
	//--------------------------------------------------------------------
	// Rules
	//--------------------------------------------------------------------
}
