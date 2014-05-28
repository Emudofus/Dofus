package org.audiofx.mp3
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.pools.Poolable;
   import flash.utils.ByteArray;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.net.FileReference;
   import flash.events.IOErrorEvent;
   
   class MP3Parser extends EventDispatcher implements Poolable
   {
      
      function MP3Parser(param1:MP3FileReferenceLoader) {
         super();
         this.m_parent = param1;
      }
      
      private static var bitRates:Array = [-1,32,40,48,56,64,80,96,112,128,160,192,224,256,320,-1,-1,8,16,24,32,40,48,56,64,80,96,112,128,144,160,-1];
      
      private static var versions:Array = [2.5,-1,2,1];
      
      private static var samplingRates:Array = [44100,48000,32000];
      
      private var mp3Data:ByteArray;
      
      private var loader:URLLoader;
      
      private var currentPosition:uint;
      
      private var sampleRate:uint;
      
      public var channels:uint;
      
      private var version:uint;
      
      private var m_parent:MP3FileReferenceLoader;
      
      public function loadMP3ByteArray(param1:ByteArray) : void {
         this.mp3Data = param1;
         this.currentPosition = this.getFirstHeaderPosition();
         this.m_parent.parsingDone(this);
      }
      
      public function free() : void {
         this.mp3Data.clear();
         this.mp3Data = null;
         this.loader = null;
         this.currentPosition = 0;
      }
      
      function load(param1:String) : void {
         this.loader = new URLLoader();
         this.loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.loader.addEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         var _loc2_:URLRequest = new URLRequest(param1);
         this.loader.load(_loc2_);
      }
      
      function loadFileRef(param1:FileReference) : void {
         param1.addEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         param1.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         param1.load();
      }
      
      private function errorHandler(param1:IOErrorEvent) : void {
         trace("error\n" + param1.text);
      }
      
      private function loaderCompleteHandler(param1:Event) : void {
         param1.target.removeEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         this.mp3Data = param1.currentTarget.data as ByteArray;
         this.currentPosition = this.getFirstHeaderPosition();
         dispatchEvent(param1);
      }
      
      private function getFirstHeaderPosition() : uint {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         this.mp3Data.position = 0;
         while(this.mp3Data.position < this.mp3Data.length)
         {
            _loc1_ = this.mp3Data.position;
            _loc2_ = this.mp3Data.readUTFBytes(3);
            if(_loc2_ == "ID3")
            {
               this.mp3Data.position = this.mp3Data.position + 3;
               _loc4_ = (this.mp3Data.readByte() & 127) << 21;
               _loc5_ = (this.mp3Data.readByte() & 127) << 14;
               _loc6_ = (this.mp3Data.readByte() & 127) << 7;
               _loc7_ = this.mp3Data.readByte() & 127;
               _loc8_ = _loc7_ + _loc6_ + _loc5_ + _loc4_;
               _loc9_ = this.mp3Data.position + _loc8_;
               this.mp3Data.position = _loc9_;
               _loc1_ = _loc9_;
            }
            else
            {
               this.mp3Data.position = _loc1_;
            }
            _loc3_ = this.mp3Data.readInt();
            if(this.isValidHeader(_loc3_))
            {
               this.parseHeader(_loc3_);
               this.mp3Data.position = _loc1_ + this.getFrameSize(_loc3_);
               if(this.isValidHeader(this.mp3Data.readInt()))
               {
                  return _loc1_;
               }
            }
         }
         throw new Error("Could not locate first header. This isn\'t an MP3 file");
      }
      
      function getNextFrame() : ByteArraySegment {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         this.mp3Data.position = this.currentPosition;
         while(this.currentPosition <= this.mp3Data.length - 4)
         {
            _loc1_ = this.mp3Data.readInt();
            if(this.isValidHeader(_loc1_))
            {
               _loc2_ = this.getFrameSize(_loc1_);
               if(_loc2_ != 4.294967295E9)
               {
                  this.mp3Data.position = this.currentPosition;
                  if(this.currentPosition + _loc2_ > this.mp3Data.length)
                  {
                     return null;
                  }
                  this.currentPosition = this.currentPosition + _loc2_;
                  return new ByteArraySegment(this.mp3Data,this.mp3Data.position,_loc2_);
               }
            }
            this.currentPosition = this.mp3Data.position;
         }
         return null;
      }
      
      function writeSwfFormatByte(param1:ByteArray) : void {
         var _loc2_:uint = 4 - 44100 / this.sampleRate;
         param1.writeByte((2 << 4) + (_loc2_ << 2) + (1 << 1) + (this.channels-1));
      }
      
      private function parseHeader(param1:uint) : void {
         var _loc2_:uint = this.getModeIndex(param1);
         this.version = this.getVersionIndex(param1);
         var _loc3_:uint = this.getFrequencyIndex(param1);
         this.channels = _loc2_ > 2?1:2;
         var _loc4_:Number = versions[this.version];
         var _loc5_:Array = [44100,48000,32000];
         this.sampleRate = _loc5_[_loc3_];
         switch(_loc4_)
         {
            case 2:
               this.sampleRate = this.sampleRate / 2;
               break;
            case 2.5:
               this.sampleRate = this.sampleRate / 4;
         }
      }
      
      private function getFrameSize(param1:uint) : uint {
         var _loc2_:uint = this.getVersionIndex(param1);
         var _loc3_:uint = this.getBitrateIndex(param1);
         var _loc4_:uint = this.getFrequencyIndex(param1);
         var _loc5_:uint = this.getPaddingBit(param1);
         var _loc6_:uint = this.getModeIndex(param1);
         var _loc7_:Number = versions[_loc2_];
         var _loc8_:uint = samplingRates[_loc4_];
         if(this.version != _loc2_)
         {
            return 4.294967295E9;
         }
         switch(_loc7_)
         {
            case 2:
               _loc8_ = _loc8_ / 2;
               break;
            case 2.5:
               _loc8_ = _loc8_ / 4;
         }
         var _loc9_:uint = (_loc7_ == 1?0:1) * bitRates.length / 2;
         var _loc10_:uint = bitRates[_loc9_ + _loc3_] * 1000;
         var _loc11_:uint = (_loc7_ == 1?144:72) * _loc10_ / _loc8_ + _loc5_;
         return _loc11_;
      }
      
      private function isValidHeader(param1:uint) : Boolean {
         return (this.getFrameSync(param1) & 2047) == 2047 && !((this.getVersionIndex(param1) & 3) == 1) && !((this.getLayerIndex(param1) & 3) == 0) && !((this.getBitrateIndex(param1) & 15) == 0) && !((this.getBitrateIndex(param1) & 15) == 15) && !((this.getFrequencyIndex(param1) & 3) == 3) && !((this.getEmphasisIndex(param1) & 3) == 2);
      }
      
      private function getFrameSync(param1:uint) : uint {
         return uint(param1 >> 21 & 2047);
      }
      
      private function getVersionIndex(param1:uint) : uint {
         return uint(param1 >> 19 & 3);
      }
      
      private function getLayerIndex(param1:uint) : uint {
         return uint(param1 >> 17 & 3);
      }
      
      private function getBitrateIndex(param1:uint) : uint {
         return uint(param1 >> 12 & 15);
      }
      
      private function getFrequencyIndex(param1:uint) : uint {
         return uint(param1 >> 10 & 3);
      }
      
      private function getPaddingBit(param1:uint) : uint {
         return uint(param1 >> 9 & 1);
      }
      
      private function getModeIndex(param1:uint) : uint {
         return uint(param1 >> 6 & 3);
      }
      
      private function getEmphasisIndex(param1:uint) : uint {
         return uint(param1 & 3);
      }
   }
}
