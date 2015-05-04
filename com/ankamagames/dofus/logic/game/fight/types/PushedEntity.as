package com.ankamagames.dofus.logic.game.fight.types
{
   public class PushedEntity extends Object
   {
      
      public function PushedEntity(param1:int, param2:uint, param3:int)
      {
         super();
         this._id = param1;
         this._pushedIndexes = new Vector.<uint>(0);
         this._pushedIndexes.push(param2);
         this._force = param3;
      }
      
      private var _id:int;
      
      private var _pushedIndexes:Vector.<uint>;
      
      private var _force:int;
      
      private var _pushingEntity:PushedEntity;
      
      private var _damage:int;
      
      private var _criticalDamage:int;
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function get pushedIndexes() : Vector.<uint>
      {
         return this._pushedIndexes;
      }
      
      public function set pushedIndexes(param1:Vector.<uint>) : void
      {
         this._pushedIndexes = param1;
      }
      
      public function get force() : int
      {
         return this._force;
      }
      
      public function set force(param1:int) : void
      {
         this._force = param1;
      }
      
      public function get pushingEntity() : PushedEntity
      {
         return this._pushingEntity;
      }
      
      public function set pushingEntity(param1:PushedEntity) : void
      {
         this._pushingEntity = param1;
      }
      
      public function get damage() : int
      {
         return this._damage;
      }
      
      public function set damage(param1:int) : void
      {
         this._damage = param1;
      }
      
      public function get criticalDamage() : int
      {
         return this._criticalDamage;
      }
      
      public function set criticalDamage(param1:int) : void
      {
         this._criticalDamage = param1;
      }
   }
}
