package com.ankamagames.dofus.logic.game.fight.types
{
   import __AS3__.vec.*;
   
   public class PushedEntity extends Object
   {
      
      public function PushedEntity(pEntityId:int, pFirstIndex:uint, pForce:int) {
         super();
         this._id = pEntityId;
         this._pushedIndexes = new Vector.<uint>(0);
         this._pushedIndexes.push(pFirstIndex);
         this._force = pForce;
      }
      
      private var _id:int;
      
      private var _pushedIndexes:Vector.<uint>;
      
      private var _force:int;
      
      private var _pushingEntity:PushedEntity;
      
      private var _damage:int;
      
      public function get id() : int {
         return this._id;
      }
      
      public function set id(value:int) : void {
         this._id = value;
      }
      
      public function get pushedIndexes() : Vector.<uint> {
         return this._pushedIndexes;
      }
      
      public function set pushedIndexes(value:Vector.<uint>) : void {
         this._pushedIndexes = value;
      }
      
      public function get force() : int {
         return this._force;
      }
      
      public function set force(value:int) : void {
         this._force = value;
      }
      
      public function get pushingEntity() : PushedEntity {
         return this._pushingEntity;
      }
      
      public function set pushingEntity(value:PushedEntity) : void {
         this._pushingEntity = value;
      }
      
      public function get damage() : int {
         return this._damage;
      }
      
      public function set damage(value:int) : void {
         this._damage = value;
      }
   }
}
