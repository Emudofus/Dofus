package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   
   public class UiGroup extends Object implements IModuleUtil
   {
      
      public function UiGroup(param1:String, param2:Boolean, param3:Boolean, param4:Array=null) {
         super();
         this._name = param1;
         this._permanent = param3;
         this._exclusive = param2;
         if(param4 != null)
         {
            this._uisName = param4;
         }
         else
         {
            this._uisName = new Array();
         }
      }
      
      private var _name:String;
      
      private var _exclusive:Boolean;
      
      private var _permanent:Boolean;
      
      private var _uisName:Array;
      
      public function get name() : String {
         return this._name;
      }
      
      public function get exclusive() : Boolean {
         return this._exclusive;
      }
      
      public function get permanent() : Boolean {
         return this._permanent;
      }
      
      public function get uis() : Array {
         return this._uisName;
      }
   }
}
