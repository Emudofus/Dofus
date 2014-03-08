package com.ankamagames.berilia.types.data
{
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   
   public class ApiAction extends Object
   {
      
      public function ApiAction(name:String, actionClass:Class, trusted:Boolean, needInteraction:Boolean, maxUsePerFrame:uint, minimalUseInterval:uint, needConfirmation:Boolean) {
         super();
         if(!_apiActionNameList)
         {
            _apiActionNameList = new Array();
         }
         if(_apiActionNameList[name])
         {
            throw new BeriliaError("ApiAction name (" + name + ") aleardy used, please rename it.");
         }
         else
         {
            _apiActionNameList[name] = this;
            this._name = name;
            this._actionClass = actionClass;
            this._trusted = trusted;
            this._needInteraction = needInteraction;
            this._maxUsePerFrame = maxUsePerFrame;
            this._minimalUseInterval = minimalUseInterval;
            this._needConfirmation = needConfirmation;
            MEMORY_LOG[this] = 1;
            return;
         }
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static var _apiActionNameList:Array = new Array();
      
      public static function getApiActionByName(name:String) : ApiAction {
         return _apiActionNameList[name];
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
