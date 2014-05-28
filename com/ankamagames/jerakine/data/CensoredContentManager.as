package com.ankamagames.jerakine.data
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class CensoredContentManager extends Object
   {
      
      public function CensoredContentManager() {
         this._data = new Dictionary();
         this._emtptyData = new Dictionary();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            return;
         }
      }
      
      private static var _self:CensoredContentManager;
      
      public static function getInstance() : CensoredContentManager {
         if(!_self)
         {
            _self = new CensoredContentManager();
         }
         return _self;
      }
      
      private var _data:Dictionary;
      
      private var _emtptyData:Dictionary;
      
      public function init(content:Array, lang:String) : void {
         var censoredData:ICensoredDataItem = null;
         for each(censoredData in content)
         {
            if(censoredData.lang == lang)
            {
               if(!this._data[censoredData.type])
               {
                  this._data[censoredData.type] = new Dictionary();
               }
               this._data[censoredData.type][censoredData.oldValue] = censoredData.newValue;
            }
         }
      }
      
      public function getCensoredIndex(type:int) : Dictionary {
         return this._data[type]?this._data[type]:this._emtptyData;
      }
   }
}
