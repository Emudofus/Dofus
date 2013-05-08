package com.ankamagames.berilia.types.data
{
   import com.ankamagames.berilia.interfaces.IModuleUtil;
   import com.ankamagames.berilia.utils.errors.BeriliaError;


   public class UiData extends Object implements IModuleUtil
   {
         

      public function UiData(module:UiModule, name:String, file:String, uiClassName:String, uiGroupName:String=null) {
         super();
         this._module=module;
         this._name=name;
         this._file=file;
         this._uiClassName=uiClassName;
         this._uiGroupName=uiGroupName;
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

      public function set xml(v:String) : void {
         if(this._xml)
         {
            throw new BeriliaError("xml cannot be set twice");
         }
         else
         {
            this._xml=v;
            return;
         }
      }

      public function get uiClass() : Class {
         return this._uiClass;
      }

      public function set uiClass(c:Class) : void {
         if(this._uiClass)
         {
            throw new BeriliaError("uiClass cannot be set twice");
         }
         else
         {
            this._uiClass=c;
            return;
         }
      }
   }

}