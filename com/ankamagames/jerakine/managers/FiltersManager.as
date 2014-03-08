package com.ankamagames.jerakine.managers
{
   import flash.utils.Dictionary;
   import flash.display.DisplayObject;
   import flash.filters.BitmapFilter;
   
   public class FiltersManager extends Object
   {
      
      public function FiltersManager(param1:PrivateClass) {
         super();
         this.dFilters = new Dictionary(true);
      }
      
      private static var _self:FiltersManager;
      
      public static function getInstance() : FiltersManager {
         if(_self == null)
         {
            _self = new FiltersManager(new PrivateClass());
         }
         return _self;
      }
      
      private var dFilters:Dictionary;
      
      public function addEffect(param1:DisplayObject, param2:BitmapFilter) : void {
         var _loc3_:Array = this.dFilters[param1] as Array;
         if(_loc3_ == null)
         {
            _loc3_ = this.dFilters[param1] = param1.filters;
         }
         _loc3_.push(param2);
         param1.filters = _loc3_;
      }
      
      public function removeEffect(param1:DisplayObject, param2:BitmapFilter) : void {
         var _loc3_:Array = this.dFilters[param1] as Array;
         if(_loc3_ == null)
         {
            _loc3_ = this.dFilters[param1] = param1.filters;
         }
         var _loc4_:int = this.indexOf(_loc3_,param2);
         if(_loc4_ != -1)
         {
            _loc3_.splice(_loc4_,1);
            param1.filters = _loc3_;
         }
      }
      
      public function indexOf(param1:Array, param2:BitmapFilter) : int {
         var _loc4_:BitmapFilter = null;
         var _loc3_:int = param1.length;
         while(_loc3_--)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_ == param2)
            {
               return _loc3_;
            }
         }
         return -1;
      }
   }
}
class PrivateClass extends Object
{
   
   function PrivateClass() {
      super();
   }
}
