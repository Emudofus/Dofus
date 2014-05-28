package org.audiofx.mp3
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.pools.Poolable;
   import flash.utils.ByteArray;
   import flash.events.Event;
   import flash.net.FileReference;
   import flash.utils.Endian;
   import flash.display.Loader;
   import flash.system.LoaderContext;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.display.LoaderInfo;
   import flash.media.Sound;
   
   public class MP3FileReferenceLoader extends EventDispatcher implements Poolable
   {
      
      public function MP3FileReferenceLoader() {
         super();
         this.mp3Parser = new MP3Parser(this);
      }
      
      public static function create(param1:MP3FileReferenceLoader=null) : MP3FileReferenceLoader {
         if(!param1)
         {
            param1 = new MP3FileReferenceLoader();
         }
         return param1;
      }
      
      private var mp3Parser:MP3Parser;
      
      public function loadMP3ByteArray(param1:ByteArray) : void {
         this.mp3Parser.addEventListener(Event.COMPLETE,this.parserCompleteHandler);
         this.mp3Parser.loadMP3ByteArray(param1);
      }
      
      public function parsingDone(param1:MP3Parser) : void {
         this.generateSound(param1);
      }
      
      public function getSound(param1:FileReference) : void {
         this.mp3Parser.addEventListener(Event.COMPLETE,this.parserCompleteHandler);
         this.mp3Parser.loadFileRef(param1);
      }
      
      public function free() : void {
         this.mp3Parser.free();
         this.mp3Parser.removeEventListener(Event.COMPLETE,this.parserCompleteHandler);
      }
      
      private function parserCompleteHandler(param1:Event) : void {
         var _loc2_:MP3Parser = param1.currentTarget as MP3Parser;
         this.generateSound(_loc2_);
      }
      
      private function generateSound(param1:MP3Parser) : Boolean {
         var _loc12_:ByteArraySegment = null;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         var _loc3_:uint = 0;
         while(_loc3_ < SoundClassSwfByteCode.soundClassSwfBytes1.length)
         {
            _loc2_.writeByte(SoundClassSwfByteCode.soundClassSwfBytes1[_loc3_]);
            _loc3_++;
         }
         var _loc4_:uint = _loc2_.position;
         _loc2_.writeInt(0);
         _loc3_ = 0;
         while(_loc3_ < SoundClassSwfByteCode.soundClassSwfBytes2.length)
         {
            _loc2_.writeByte(SoundClassSwfByteCode.soundClassSwfBytes2[_loc3_]);
            _loc3_++;
         }
         var _loc5_:uint = _loc2_.position;
         _loc2_.writeInt(0);
         _loc2_.writeByte(1);
         _loc2_.writeByte(0);
         param1.writeSwfFormatByte(_loc2_);
         var _loc6_:uint = _loc2_.position;
         _loc2_.writeInt(0);
         _loc2_.writeByte(0);
         _loc2_.writeByte(0);
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(true)
         {
            _loc12_ = param1.getNextFrame();
            if(_loc12_ == null)
            {
               break;
            }
            _loc2_.writeBytes(_loc12_.byteArray,_loc12_.start,_loc12_.length);
            _loc8_ = _loc8_ + _loc12_.length;
            _loc7_++;
         }
         if(_loc8_ == 0)
         {
            return false;
         }
         _loc8_ = _loc8_ + 2;
         var _loc9_:uint = _loc2_.position;
         _loc2_.position = _loc5_;
         _loc2_.writeInt(_loc8_ + 7);
         _loc2_.position = _loc6_;
         _loc2_.writeInt(_loc7_ * 1152);
         _loc2_.position = _loc9_;
         _loc3_ = 0;
         while(_loc3_ < SoundClassSwfByteCode.soundClassSwfBytes3.length)
         {
            _loc2_.writeByte(SoundClassSwfByteCode.soundClassSwfBytes3[_loc3_]);
            _loc3_++;
         }
         _loc2_.position = _loc4_;
         _loc2_.writeInt(_loc2_.length);
         _loc2_.position = 0;
         var _loc10_:Loader = new Loader();
         _loc10_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.swfCreated);
         var _loc11_:LoaderContext = new LoaderContext();
         AirScanner.allowByteCodeExecution(_loc11_,true);
         _loc10_.loadBytes(_loc2_,_loc11_);
         return true;
      }
      
      private function swfCreated(param1:Event) : void {
         param1.target.removeEventListener(param1.type,this.swfCreated);
         var _loc2_:LoaderInfo = param1.currentTarget as LoaderInfo;
         var _loc3_:Class = _loc2_.applicationDomain.getDefinition("SoundClass") as Class;
         var _loc4_:Sound = new _loc3_();
         dispatchEvent(new MP3SoundEvent(MP3SoundEvent.COMPLETE,_loc4_,this.mp3Parser.channels));
      }
   }
}
