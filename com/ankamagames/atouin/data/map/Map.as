package com.ankamagames.atouin.data.map
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.IDataInput;
   import flash.utils.ByteArray;
   import com.ankamagames.atouin.data.DataFormatError;
   import com.ankamagames.atouin.AtouinConstants;
   import flash.errors.IllegalOperationError;
   import com.ankamagames.atouin.data.map.elements.BasicElement;
   import com.ankamagames.atouin.data.elements.GraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
   import com.ankamagames.atouin.data.elements.Elements;
   import com.ankamagames.atouin.enums.ElementTypesEnum;
   import com.ankamagames.atouin.data.map.elements.GraphicalElement;
   
   public class Map extends Object
   {
      
      public function Map() {
         this.mapClass = Map;
         this.topArrowCell = [];
         this.leftArrowCell = [];
         this.bottomArrowCell = [];
         this.rightArrowCell = [];
         super();
      }
      
      protected static const _log:Logger;
      
      public var mapClass:Class;
      
      public var mapVersion:int;
      
      public var encrypted:Boolean;
      
      public var encryptionVersion:uint;
      
      public var groundCRC:int;
      
      public var zoomScale:Number = 1;
      
      public var zoomOffsetX:int;
      
      public var zoomOffsetY:int;
      
      public var groundCacheCurrentlyUsed:int = 0;
      
      public var id:int;
      
      public var relativeId:int;
      
      public var mapType:int;
      
      public var backgroundsCount:int;
      
      public var backgroundFixtures:Array;
      
      public var foregroundsCount:int;
      
      public var foregroundFixtures:Array;
      
      public var subareaId:int;
      
      public var shadowBonusOnEntities:int;
      
      public var backgroundColor:uint;
      
      public var backgroundRed:int;
      
      public var backgroundGreen:int;
      
      public var backgroundBlue:int;
      
      public var topNeighbourId:int;
      
      public var bottomNeighbourId:int;
      
      public var leftNeighbourId:int;
      
      public var rightNeighbourId:int;
      
      public var useLowPassFilter:Boolean;
      
      public var useReverb:Boolean;
      
      public var presetId:int;
      
      public var cellsCount:int;
      
      public var layersCount:int;
      
      public var isUsingNewMovementSystem:Boolean = false;
      
      public var layers:Array;
      
      public var cells:Array;
      
      public var topArrowCell:Array;
      
      public var leftArrowCell:Array;
      
      public var bottomArrowCell:Array;
      
      public var rightArrowCell:Array;
      
      private var _parsed:Boolean;
      
      private var _failed:Boolean;
      
      private var _gfxList:Array;
      
      private var _gfxCount:Array;
      
      public function get parsed() : Boolean {
         return this._parsed;
      }
      
      public function get failed() : Boolean {
         return this._failed;
      }
      
      public function getGfxList(skipBackground:Boolean = false) : Array {
         if(!this._gfxList)
         {
            this.computeGfxList(skipBackground);
         }
         return this._gfxList;
      }
      
      public function getGfxCount(gfxId:uint) : uint {
         if(!this._gfxList)
         {
            this.computeGfxList();
         }
         return this._gfxCount[gfxId];
      }
      
      public function fromRaw(raw:IDataInput, decryptionKey:ByteArray = null) : void {
         var i:int = 0;
         var header:int = 0;
         var bg:Fixture = null;
         var la:Layer = null;
         var _oldMvtSystem:uint = 0;
         var cd:CellData = null;
         var dataLen:uint = 0;
         var encryptedData:ByteArray = null;
         var fg:Fixture = null;
         try
         {
            header = raw.readByte();
            if(header != 77)
            {
               throw new DataFormatError("Unknown file format");
            }
            else
            {
               this.mapVersion = raw.readByte();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Map version : " + this.mapVersion);
               }
               this.id = raw.readUnsignedInt();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Map id : " + this.id);
               }
               if(this.mapVersion >= 7)
               {
                  this.encrypted = raw.readBoolean();
                  this.encryptionVersion = raw.readByte();
                  dataLen = raw.readInt();
                  if(this.encrypted)
                  {
                     if(!decryptionKey)
                     {
                        throw new IllegalOperationError("Map decryption key is empty");
                     }
                     else
                     {
                        encryptedData = new ByteArray();
                        raw.readBytes(encryptedData,0,dataLen);
                        i = 0;
                        while(i < encryptedData.length)
                        {
                           encryptedData[i] = encryptedData[i] ^ decryptionKey[i % decryptionKey.length];
                           i++;
                        }
                        encryptedData.position = 0;
                        raw = encryptedData;
                     }
                  }
               }
               this.relativeId = raw.readUnsignedInt();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Map relativeId: " + this.relativeId);
               }
               this.mapType = raw.readByte();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Map type : " + this.mapType);
               }
               this.subareaId = raw.readInt();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Subarea id : " + this.subareaId);
               }
               this.topNeighbourId = raw.readInt();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("topNeighbourId : " + this.topNeighbourId);
               }
               this.bottomNeighbourId = raw.readInt();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("bottomNeighbourId : " + this.bottomNeighbourId);
               }
               this.leftNeighbourId = raw.readInt();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("leftNeighbourId : " + this.leftNeighbourId);
               }
               this.rightNeighbourId = raw.readInt();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("rightNeighbourId : " + this.rightNeighbourId);
               }
               this.shadowBonusOnEntities = raw.readInt();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("ShadowBonusOnEntities : " + this.shadowBonusOnEntities);
               }
               if(this.mapVersion >= 3)
               {
                  this.backgroundRed = raw.readByte();
                  this.backgroundGreen = raw.readByte();
                  this.backgroundBlue = raw.readByte();
                  this.backgroundColor = (this.backgroundRed & 255) << 16 | (this.backgroundGreen & 255) << 8 | this.backgroundBlue & 255;
                  if(AtouinConstants.DEBUG_FILES_PARSING)
                  {
                     _log.debug("BackgroundColor : " + this.backgroundRed + "," + this.backgroundGreen + "," + this.backgroundBlue);
                  }
               }
               if(this.mapVersion >= 4)
               {
                  this.zoomScale = raw.readUnsignedShort() / 100;
                  this.zoomOffsetX = raw.readShort();
                  this.zoomOffsetY = raw.readShort();
                  if(this.zoomScale < 1)
                  {
                     this.zoomScale = 1;
                     this.zoomOffsetX = this.zoomOffsetY = 0;
                  }
                  if(AtouinConstants.DEBUG_FILES_PARSING)
                  {
                     _log.debug("Zoom auto : " + this.zoomScale + "," + this.zoomOffsetX + "," + this.zoomOffsetY);
                  }
               }
               this.useLowPassFilter = raw.readByte() == 1;
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("useLowPassFilter : " + this.useLowPassFilter);
               }
               this.useReverb = raw.readByte() == 1;
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("useReverb : " + this.useReverb);
               }
               if(this.useReverb)
               {
                  this.presetId = raw.readInt();
               }
               else
               {
                  this.presetId = -1;
               }
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("presetId : " + this.presetId);
               }
               this.backgroundsCount = raw.readByte();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Backgrounds count : " + this.backgroundsCount);
               }
               this.backgroundFixtures = new Array();
               i = 0;
               while(i < this.backgroundsCount)
               {
                  bg = new Fixture(this);
                  if(AtouinConstants.DEBUG_FILES_PARSING)
                  {
                     _log.debug("Background at index " + i + " :");
                  }
                  bg.fromRaw(raw);
                  this.backgroundFixtures.push(bg);
                  i++;
               }
               this.foregroundsCount = raw.readByte();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Foregrounds count : " + this.foregroundsCount);
               }
               this.foregroundFixtures = new Array();
               i = 0;
               while(i < this.foregroundsCount)
               {
                  fg = new Fixture(this);
                  if(AtouinConstants.DEBUG_FILES_PARSING)
                  {
                     _log.debug("Foreground at index " + i + " :");
                  }
                  fg.fromRaw(raw);
                  this.foregroundFixtures.push(fg);
                  i++;
               }
               this.cellsCount = AtouinConstants.MAP_CELLS_COUNT;
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Cells count : " + this.cellsCount);
               }
               raw.readInt();
               this.groundCRC = raw.readInt();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("groundCRC : " + this.groundCRC);
               }
               this.layersCount = raw.readByte();
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Layers count : " + this.layersCount);
               }
               this.layers = new Array();
               i = 0;
               while(i < this.layersCount)
               {
                  la = new Layer(this);
                  if(AtouinConstants.DEBUG_FILES_PARSING)
                  {
                     _log.debug("Layer at index " + i + " :");
                  }
                  la.fromRaw(raw,this.mapVersion);
                  this.layers.push(la);
                  i++;
               }
               this.cells = new Array();
               i = 0;
               while(i < this.cellsCount)
               {
                  cd = new CellData(this,i);
                  if(AtouinConstants.DEBUG_FILES_PARSING)
                  {
                     _log.debug("Cell data at index " + i + " :");
                  }
                  cd.fromRaw(raw);
                  if(!_oldMvtSystem)
                  {
                     _oldMvtSystem = cd.moveZone;
                  }
                  if(cd.moveZone != _oldMvtSystem)
                  {
                     this.isUsingNewMovementSystem = true;
                  }
                  this.cells.push(cd);
                  i++;
               }
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  trace(this.isUsingNewMovementSystem?"This map is using the new movement system":"This map is using the old movement system");
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
      
      private function computeGfxList(skipBackground:Boolean = false) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
