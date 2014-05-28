package com.ankamagames.atouin.data.elements
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   import com.ankamagames.atouin.data.DataFormatError;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class Elements extends Object
   {
      
      public function Elements() {
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
      
      private static var _self:Elements;
      
      public static function getInstance() : Elements {
         if(!_self)
         {
            _self = new Elements();
         }
         return _self;
      }
      
      protected static const _log:Logger;
      
      public var fileVersion:uint;
      
      public var elementsCount:uint;
      
      private var _parsed:Boolean;
      
      private var _failed:Boolean;
      
      private var _elementsMap:Dictionary;
      
      private var _jpgMap:Dictionary;
      
      private var _elementsIndex:Dictionary;
      
      private var _rawData:IDataInput;
      
      public function get parsed() : Boolean {
         return this._parsed;
      }
      
      public function get failed() : Boolean {
         return this._failed;
      }
      
      public function getElementData(elementId:int) : GraphicalElementData {
         return this._elementsMap[elementId]?GraphicalElementData(this._elementsMap[elementId]):this.readElement(elementId);
      }
      
      public function isJpg(gfxId:uint) : Boolean {
         return this._jpgMap[gfxId] == true;
      }
      
      public function fromRaw(raw:IDataInput) : void {
         var header:int = 0;
         var skypLen:uint = 0;
         var i:int = 0;
         var edId:int = 0;
         var gfxCount:int = 0;
         var gfxId:int = 0;
         try
         {
            header = raw.readByte();
            if(header != 69)
            {
               throw new DataFormatError("Unknown file format");
            }
            else
            {
               this._rawData = raw;
               this.fileVersion = raw.readByte();
               if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
               {
                  _log.debug("File version : " + this.fileVersion);
               }
               this.elementsCount = raw.readUnsignedInt();
               if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
               {
                  _log.debug("Elements count : " + this.elementsCount);
               }
               this._elementsMap = new Dictionary();
               this._elementsIndex = new Dictionary();
               skypLen = 0;
               i = 0;
               while(i < this.elementsCount)
               {
                  if(this.fileVersion >= 9)
                  {
                     skypLen = raw.readUnsignedShort();
                  }
                  edId = raw.readInt();
                  if(this.fileVersion <= 8)
                  {
                     this._elementsIndex[edId] = raw["position"];
                     this.readElement(edId);
                  }
                  else
                  {
                     this._elementsIndex[edId] = raw["position"];
                     raw["position"] = raw["position"] + (skypLen - 4);
                  }
                  i++;
               }
               if(this.fileVersion >= 8)
               {
                  gfxCount = raw.readInt();
                  this._jpgMap = new Dictionary();
                  i = 0;
                  while(i < gfxCount)
                  {
                     gfxId = raw.readInt();
                     this._jpgMap[gfxId] = true;
                     i++;
                  }
               }
               this._parsed = true;
            }
         }
         catch(e:*)
         {
            _failed = true;
            throw e;
         }
      }
      
      private function readElement(edId:uint) : GraphicalElementData {
         this._rawData["position"] = this._elementsIndex[edId];
         var edType:int = this._rawData.readByte();
         var ed:GraphicalElementData = GraphicalElementFactory.getGraphicalElementData(edId,edType);
         ed.fromRaw(this._rawData,this.fileVersion);
         this._elementsMap[edId] = ed;
         return ed;
      }
   }
}
