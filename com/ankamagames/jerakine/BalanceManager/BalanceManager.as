package com.ankamagames.jerakine.BalanceManager
{
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.BalanceManager.type.BalancedObject;
   import com.ankamagames.jerakine.BalanceManager.events.BalanceEvent;
   
   public class BalanceManager extends Object
   {
      
      public function BalanceManager(param1:Array=null) {
         var _loc2_:Object = null;
         super();
         this.init();
         if(param1 != null)
         {
            for each (_loc2_ in param1)
            {
               this.addItem(_loc2_);
            }
         }
      }
      
      private var _balancedObjects:Vector.<BalancedObject>;
      
      private var _nbCall:uint = 0;
      
      public function get nbCall() : uint {
         return this._nbCall;
      }
      
      public function getItemNbCall(param1:Object) : int {
         var _loc2_:BalancedObject = null;
         for each (_loc2_ in this._balancedObjects)
         {
            if(param1 == _loc2_.item)
            {
               return _loc2_.nbCall;
            }
         }
         return -1;
      }
      
      public function setItemBalance(param1:Object, param2:uint) : void {
         var _loc3_:BalancedObject = null;
         for each (_loc3_ in this._balancedObjects)
         {
            if(param1 == _loc3_.item)
            {
               _loc3_.nbCall = param2;
               return;
            }
         }
      }
      
      public function addItem(param1:Object, param2:Boolean=false) : void {
         this._balancedObjects.push(new BalancedObject(param1));
         if(param2)
         {
            this._nbCall = 0;
            this.resetBalance();
         }
         this.balanceItems();
      }
      
      public function addItemWithBalance(param1:Object, param2:uint) : void {
         var _loc3_:BalancedObject = new BalancedObject(param1);
         _loc3_.nbCall = param2;
         this._balancedObjects.push(_loc3_);
         this._nbCall = this._nbCall + param2;
         this.balanceItems();
      }
      
      public function callItem() : Object {
         var _loc4_:BalancedObject = null;
         var _loc1_:uint = Math.random() * 10000;
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         if(this._balancedObjects.length == 0)
         {
            return _loc3_;
         }
         _loc4_ = this._balancedObjects[0] as BalancedObject;
         if(_loc1_ < _loc4_.chanceToBeCall * 100)
         {
            _loc4_.increment();
            _loc3_ = _loc4_.item;
         }
         _loc2_++;
         var _loc5_:Number = _loc4_.chanceToBeCall * 100;
         while(_loc2_ < this._balancedObjects.length)
         {
            _loc4_ = this._balancedObjects[_loc2_] as BalancedObject;
            if(_loc3_ == null)
            {
               if(this._balancedObjects.length == _loc2_ + 1)
               {
                  _loc4_.increment();
                  _loc3_ = _loc4_.item;
               }
               else
               {
                  if(_loc1_ > _loc5_ && _loc1_ < _loc5_ + _loc4_.chanceToBeCall * 100)
                  {
                     _loc4_.increment();
                     _loc3_ = _loc4_.item;
                  }
                  _loc5_ = _loc5_ + _loc4_.chanceToBeCall * 100;
               }
            }
            _loc2_++;
         }
         this._nbCall++;
         this.balanceItems();
         return _loc3_;
      }
      
      public function removeItem(param1:Object) : void {
         var _loc2_:BalancedObject = null;
         for each (_loc2_ in this._balancedObjects)
         {
            if(_loc2_.item == param1)
            {
               this._balancedObjects.splice(this._balancedObjects.indexOf(_loc2_),1);
            }
         }
         this.balanceItems();
      }
      
      public function reset() : void {
         var _loc1_:BalancedObject = null;
         for each (_loc1_ in this._balancedObjects)
         {
            this.setItemBalance(_loc1_.item,0);
         }
         this.balanceItems();
      }
      
      private function balanceItems() : void {
         var _loc1_:BalancedObject = null;
         var _loc2_:BalancedObject = null;
         var _loc3_:* = NaN;
         var _loc4_:BalancedObject = null;
         var _loc5_:BalancedObject = null;
         if(this._nbCall == 0)
         {
            for each (_loc1_ in this._balancedObjects)
            {
               _loc1_.chanceToBeCall = 1 / this._balancedObjects.length * 100;
            }
         }
         else
         {
            for each (_loc2_ in this._balancedObjects)
            {
               _loc2_.chanceToBeNonCall = (_loc2_.nbCall + 1) / (this._nbCall + this._balancedObjects.length) * 100;
            }
            _loc3_ = 0;
            for each (_loc4_ in this._balancedObjects)
            {
               _loc3_ = _loc3_ + 1 / _loc4_.chanceToBeNonCall;
            }
            for each (_loc5_ in this._balancedObjects)
            {
               _loc5_.chanceToBeCall = 1 / _loc5_.chanceToBeNonCall / _loc3_ * 100;
            }
         }
      }
      
      private function init() : void {
         this._balancedObjects = new Vector.<BalancedObject>();
      }
      
      private function resetBalance() : void {
         var _loc1_:BalancedObject = null;
         for each (_loc1_ in this._balancedObjects)
         {
            _loc1_.nbCall = 0;
         }
      }
      
      private function onBalanceUpdate(param1:BalanceEvent) : void {
         this._nbCall = this._nbCall + (param1.newBalance - param1.previousBalance);
      }
   }
}
