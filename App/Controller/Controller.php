<?php

namespace App\Controller;

interface Controller
{
   public function create();
   public function destroy();
   public function update();
   public function show();
   public function showById($id);
} 