package com.ankamagames.berilia.types.data
{
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   
   public class ApiAction extends Object
   {
      
      public function ApiAction(param1:String, param2:Class, param3:Boolean, param4:Boolean, param5:uint, param6:uint, param7:Boolean) {
         super();
         if(!_apiActionNameList)
         {
            _apiActionNameList = new Array();
         }
         if(_apiActionNameList[param1])
         {
            throw new BeriliaError("ApiAction name (" + param1 + ") aleardy used, please rename it.");
         }
         else
         {
            _apiActionNameList[param1] = this;
            this._name = param1;
            this._actionClass = param2;
            this._trusted = param3;
            this._needInteraction = param4;
            this._maxUsePerFrame = param5;
            this._minimalUseInterval = param6;
            this._needConfirmation = param7;
            MEMORY_LOG[this] = 1;
            return;
         }
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static var _apiActionNameList:Array = new Array();
      
      public static function getApiActionByName(param1:String) : ApiAction {
         return _apiActionNameList[param1];
      }
      
      public static function getApiActionsList() : Array {
         return _apiActionNameList;
      }
      
      protected var _trusted:Boolean;
      
      protected var _name:String;
      
      protected var _actionClass:Class;
      
      protected var _maxUsePerFrame:uint = 1;
      
      protected var _needInteraction:Boolean;
      
      protected var _minimalUseInterval:uint = 0;
      
      protected var _needConfirmation:Boolean;
      
      public function get trusted() : Boolean {
         return this._trusted;
      }
      
      public function get name() : String {
         return this._name;
      }
      
      public function get needInteraction() : Boolean {
         return this._needInteraction;
      }
      
      public function get maxUsePerFrame() : uint {
         return this._maxUsePerFrame;
      }
      
      public function get minimalUseInterval() : uint {
         return this._minimalUseInterval;
      }
      
      public function get needConfirmation() : Boolean {
         return this._needConfirmation;
      }
      
      public function get actionClass() : Class {
         return this._actionClass;
      }
   }
}
