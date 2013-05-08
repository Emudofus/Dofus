package org.audiofx.mp3
{
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.net.FileReference;
   import flash.events.Event;
   import flash.utils.Endian;
   import flash.display.Loader;
   import flash.system.LoaderContext;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.display.LoaderInfo;
   import flash.media.Sound;


   public class MP3FileReferenceLoader extends EventDispatcher
   {
         

      public function MP3FileReferenceLoader() {
         super();
         this.mp3Parser=new MP3Parser(this);
         this.mp3Parser.addEventListener(Event.COMPLETE,this.parserCompleteHandler);
      }



      private var mp3Parser:MP3Parser;

      public function loadMP3ByteArray(ba:ByteArray) : void {
         this.mp3Parser.loadMP3ByteArray(ba);
      }

      public function parsingDone(parser:MP3Parser) : void {
         this.generateSound(parser);
      }

      public function getSound(fr:FileReference) : void {
         this.mp3Parser.loadFileRef(fr);
      }

      private function parserCompleteHandler(ev:Event) : void {
         var parser:MP3Parser = ev.currentTarget as MP3Parser;
         this.generateSound(parser);
      }

      private function generateSound(mp3Source:MP3Parser) : Boolean {
         var seg:ByteArraySegment = null;
         var swfBytes:ByteArray = new ByteArray();
         swfBytes.endian=Endian.LITTLE_ENDIAN;
         var i:uint = 0;
         while(i<SoundClassSwfByteCode.soundClassSwfBytes1.length)
         {
            swfBytes.writeByte(SoundClassSwfByteCode.soundClassSwfBytes1[i]);
            i++;
         }
         var swfSizePosition:uint = swfBytes.position;
         swfBytes.writeInt(0);
         i=0;
         while(i<SoundClassSwfByteCode.soundClassSwfBytes2.length)
         {
            swfBytes.writeByte(SoundClassSwfByteCode.soundClassSwfBytes2[i]);
            i++;
         }
         var audioSizePosition:uint = swfBytes.position;
         swfBytes.writeInt(0);
         swfBytes.writeByte(1);
         swfBytes.writeByte(0);
         mp3Source.writeSwfFormatByte(swfBytes);
         var sampleSizePosition:uint = swfBytes.position;
         swfBytes.writeInt(0);
         swfBytes.writeByte(0);
         swfBytes.writeByte(0);
         var frameCount:uint = 0;
         var byteCount:uint = 0;
         do
         {
            seg=mp3Source.getNextFrame();
            if(seg==null)
            {
               if(byteCount==0)
               {
                  return false;
               }
               byteCount=byteCount+2;
               currentPos=swfBytes.position;
               swfBytes.position=audioSizePosition;
               swfBytes.writeInt(byteCount+7);
               swfBytes.position=sampleSizePosition;
               swfBytes.writeInt(frameCount*1152);
               swfBytes.position=currentPos;
               i=0;
               while(i<SoundClassSwfByteCode.soundClassSwfBytes3.length)
               {
                  swfBytes.writeByte(SoundClassSwfByteCode.soundClassSwfBytes3[i]);
                  i++;
               }
               swfBytes.position=swfSizePosition;
               swfBytes.writeInt(swfBytes.length);
               swfBytes.position=0;
               swfBytesLoader=new Loader();
               swfBytesLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.swfCreated);
               lc=new LoaderContext();
               AirScanner.allowByteCodeExecution(lc,true);
               swfBytesLoader.loadBytes(swfBytes,lc);
               return true;
            }
            swfBytes.writeBytes(seg.byteArray,seg.start,seg.length);
            byteCount=byteCount+seg.length;
            frameCount++;
         }
         while(true);
      }

      private function swfCreated(ev:Event) : void {
         var loaderInfo:LoaderInfo = ev.currentTarget as LoaderInfo;
         var soundClass:Class = loaderInfo.applicationDomain.getDefinition("SoundClass") as Class;
         var sound:Sound = new soundClass();
         dispatchEvent(new MP3SoundEvent(MP3SoundEvent.COMPLETE,sound));
      }
   }

}