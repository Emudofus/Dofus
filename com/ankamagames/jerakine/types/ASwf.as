package com.ankamagames.jerakine.types
{
   import flash.display.DisplayObject;
   import flash.system.ApplicationDomain;
   
   public class ASwf extends Object
   {
      
      public function ASwf(param1:DisplayObject, param2:ApplicationDomain, param3:Number, param4:Number) {
         super();
         this._content = param1;
         this._appDomain = param2;
         this._loaderWidth = param3;
         this._loaderHeight = param4;
      }
      
      private var _content:DisplayObject;
      
      private var _appDomain:ApplicationDomain;
      
      private var _loaderWidth:Number;
      
      private var _loaderHeight:Number;
      
      public function get content() : DisplayObject {
         return this._content;
      }
      
      public function get applicationDomain() : ApplicationDomain {
         return this._appDomain;
      }
      
      public function get loaderWidth() : Number {
         return this._loaderWidth;
      }
      
      public function get loaderHeight() : Number {
         return this._loaderHeight;
      }
   }
}
