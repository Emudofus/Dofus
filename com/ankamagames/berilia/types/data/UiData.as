package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.errors.IllegalOperationError;
   
   public class UiData extends Object implements IModuleUtil
   {
      
      public function UiData(param1:UiModule, param2:String, param3:String, param4:String, param5:String=null) {
         super();
         this._module = param1;
         this._name = param2;
         this._file = param3;
         this._uiClassName = param4;
         this._uiGroupName = param5;
      }
      
      private var _name:String;
      
      private var _file:String;
      
      private var _uiClassName:String;
      
      private var _uiClass:Class;
      
      private var _xml:String;
      
      private var _uiGroupName:String;
      
      private var _module:UiModule;
      
      public function get module() : UiModule {
         return this._module;
      }
      
      public function get name() : String {
         return this._name;
      }
      
      public function get file() : String {
         return this._file;
      }
      
      public function get uiClassName() : String {
         return this._uiClassName;
      }
      
      public function get xml() : String {
         return this._xml;
      }
      
      public function get uiGroupName() : String {
         return this._uiGroupName;
      }
      
      public function set xml(param1:String) : void {
         if(this._xml)
         {
            throw new BeriliaError("xml cannot be set twice");
         }
         else
         {
            this._xml = param1;
            return;
         }
      }
      
      public function get uiClass() : Class {
         return this._uiClass;
      }
      
      public function set uiClass(param1:Class) : void {
         if(this._uiClass)
         {
            throw new BeriliaError("uiClass cannot be set twice");
         }
         else
         {
            this._uiClass = param1;
            return;
         }
      }
      
      public function updateXml(param1:XML, param2:Object) : void {
         if(param2 != SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError("Wrong access key");
         }
         else
         {
            this._xml = param1;
            return;
         }
      }
   }
}
