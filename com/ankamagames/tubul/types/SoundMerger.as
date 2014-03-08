package com.ankamagames.tubul.types
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.utils.Dictionary;
   import flash.utils.ByteArray;
   import flash.events.Event;
   import __AS3__.vec.*;
   import flash.events.SampleDataEvent;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.utils.getTimer;
   
   public class SoundMerger extends EventDispatcher
   {
      
      public function SoundMerger() {
         super();
         this.init();
      }
      
      private static const DATA_SAMPLES_BUFFER_SIZE:uint = 4096;
      
      private static const SILENCE_SAMPLES_BUFFER_SIZE:uint = 2048;
      
      public static const MINIMAL_LENGTH_TO_MERGE:uint = 3500;
      
      public static const MAXIMAL_LENGTH_TO_MERGE:uint = 10000;
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundMerger));
      
      private var _output:Sound;
      
      private var _outputChannel:SoundChannel;
      
      private var _sounds:Vector.<SoundWrapper>;
      
      private var _soundsCount:uint;
      
      private var _directlyPlayed:Dictionary;
      
      private var _directChannels:Dictionary;
      
      private var _outputBytes:ByteArray;
      
      private var _cuttingBytes:ByteArray;
      
      public function getSoundChannel(sw:SoundWrapper) : SoundChannel {
         return this._directlyPlayed[sw];
      }
      
      public function addSound(sw:SoundWrapper) : void {
         this.directPlay(sw,sw.loops);
      }
      
      public function removeSound(sw:SoundWrapper) : void {
         var soundPos:int = this._sounds.indexOf(sw);
         if(soundPos != -1)
         {
            this._sounds.splice(soundPos,1);
            sw.dispatchEvent(new Event(Event.SOUND_COMPLETE));
            if(!--this._soundsCount)
            {
               this.setSilence(true);
            }
         }
         else
         {
            if(this._directlyPlayed[sw])
            {
               this.directStop(sw);
            }
         }
      }
      
      private function init() : void {
         this._sounds = new Vector.<SoundWrapper>();
         this._directlyPlayed = new Dictionary();
         this._directChannels = new Dictionary();
         this._cuttingBytes = new ByteArray();
         this._output = new Sound();
         this._output.addEventListener(SampleDataEvent.SAMPLE_DATA,this.sampleSilence);
         this._outputChannel = this._output.play();
         StageShareManager.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function setSilence(activated:Boolean) : void {
         if(activated)
         {
            this._output.removeEventListener(SampleDataEvent.SAMPLE_DATA,this.sampleData);
            this._output.addEventListener(SampleDataEvent.SAMPLE_DATA,this.sampleSilence);
         }
         else
         {
            this._output.addEventListener(SampleDataEvent.SAMPLE_DATA,this.sampleData);
            this._output.removeEventListener(SampleDataEvent.SAMPLE_DATA,this.sampleSilence);
         }
      }
      
      private function directPlay(sw:SoundWrapper, loops:int) : void {
         var directChannel:SoundChannel = null;
         if(!StageShareManager.stage.hasEventListener(Event.ENTER_FRAME))
         {
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         directChannel = sw.sound.play(0,1,sw.getSoundTransform());
         if(directChannel == null)
         {
            _log.error("directChannel is null !");
            return;
         }
         if(this._directlyPlayed[sw] != null)
         {
            this._directChannels[this._directlyPlayed[sw]] = null;
            delete this._directChannels[[this._directlyPlayed[sw]]];
         }
         this._directlyPlayed[sw] = directChannel;
         this._directChannels[directChannel] = sw;
         if(!directChannel.hasEventListener(Event.SOUND_COMPLETE))
         {
            directChannel.addEventListener(Event.SOUND_COMPLETE,this.directSoundComplete);
         }
      }
      
      private function directStop(sw:SoundWrapper, eventDispatched:Boolean=false) : void {
         var directChannel:SoundChannel = this._directlyPlayed[sw];
         directChannel.removeEventListener(Event.SOUND_COMPLETE,this.directSoundComplete);
         directChannel.stop();
         sw.currentLoop = 0;
         if(!eventDispatched)
         {
            sw.dispatchEvent(new Event(Event.SOUND_COMPLETE));
         }
         delete this._directlyPlayed[[sw]];
         delete this._directChannels[[directChannel]];
         if((StageShareManager.stage.hasEventListener(Event.ENTER_FRAME)) && (this._directChannels.length == 0))
         {
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      private function sampleData(sde:SampleDataEvent) : void {
         var previousPosition:uint = 0;
         var samplesRemaining:* = NaN;
         var samplesExtracted:* = NaN;
         var cutValueR:* = NaN;
         var cutValueL:* = NaN;
         var cutSamples:uint = 0;
         var cuttingPosition:uint = 0;
         var i:uint = 0;
         var j:uint = 0;
         var k:uint = 0;
         var baHolder:ByteArray = null;
         var sw:SoundWrapper = null;
         var extractFinished:* = false;
         var l:* = NaN;
         var r:* = NaN;
         var sl:* = NaN;
         var sr:* = NaN;
         var firstPass:* = false;
         var startSampleData:uint = getTimer();
         var out:ByteArray = sde.data;
         j = 0;
         while(j < this._soundsCount)
         {
            sw = this._sounds[j] as SoundWrapper;
            if(!sw._extractFinished)
            {
               samplesRemaining = DATA_SAMPLES_BUFFER_SIZE;
               previousPosition = sw.soundData.position;
               firstPass = true;
               do
               {
                     if((previousPosition == 0) && (firstPass))
                     {
                        samplesExtracted = sw.sound.extract(sw.soundData,samplesRemaining,0);
                     }
                     else
                     {
                        samplesExtracted = sw.sound.extract(sw.soundData,samplesRemaining);
                     }
                     firstPass = false;
                     extractFinished = !(samplesExtracted == samplesRemaining);
                     if((!sw.hadBeenCut) && ((sw.loops == 0) || (sw.loops > 1)))
                     {
                        sw.currentLoop++;
                        sw.soundData.position = cuttingPosition;
                        i = 0;
                        while(i < samplesExtracted)
                        {
                           cutValueR = sw.soundData.readFloat();
                           cutValueL = sw.soundData.readFloat();
                           if((cutValueR > 0.001) || (cutValueR < -0.001) || (cutValueL > 0.001) || (cutValueL < -0.001))
                           {
                              sw.hadBeenCut = true;
                              break;
                           }
                           i++;
                        }
                        cutSamples = i + 1;
                        i = i + 1;
                        while(i < samplesExtracted)
                        {
                           this._cuttingBytes.writeFloat(sw.soundData.readFloat());
                           this._cuttingBytes.writeFloat(sw.soundData.readFloat());
                           i++;
                        }
                        if(this._cuttingBytes.length > 0)
                        {
                           samplesRemaining = samplesRemaining + cutSamples;
                           baHolder = sw.soundData;
                           sw.soundData = this._cuttingBytes;
                           this._cuttingBytes = baHolder;
                           this._cuttingBytes.clear();
                        }
                        else
                        {
                           cuttingPosition = cuttingPosition + DATA_SAMPLES_BUFFER_SIZE * 8;
                           samplesRemaining = samplesRemaining + DATA_SAMPLES_BUFFER_SIZE;
                        }
                     }
                     if(extractFinished)
                     {
                        sw.extractFinished();
                        break;
                     }
                     samplesRemaining = samplesRemaining - samplesExtracted;
                  }while(samplesRemaining > 0);
                  
                  sw.soundData.position = previousPosition;
               }
               j++;
            }
            i = 0;
            while(i < DATA_SAMPLES_BUFFER_SIZE)
            {
               l = r = 0.0;
               j = 0;
               while(j < this._soundsCount)
               {
                  if(i == 0)
                  {
                     sw.checkSoundPosition();
                  }
                  sw = this._sounds[j] as SoundWrapper;
                  if(sw.soundData.bytesAvailable < 8)
                  {
                     if((sw.loops == 0) || (sw.loops > 1) && (sw.currentLoop + 1 < sw.loops))
                     {
                        sw.soundData.position = 0;
                        sw.currentLoop++;
                     }
                     else
                     {
                        this.removeSound(sw);
                        break;
                     }
                  }
                  else
                  {
                     sl = sw.soundData.readFloat() * sw._volume * (1 - sw._pan);
                     sr = sw.soundData.readFloat() * sw._volume * (1 + sw._pan);
                     l = l + (sl * sw._leftToLeft + sr * sw._rightToLeft);
                     r = r + (sl * sw._leftToRight + sr * sw._rightToRight);
                  }
                  j++;
               }
               if(l > 1)
               {
                  l = 1;
               }
               if(l < -1)
               {
                  l = -1;
               }
               if(r > 1)
               {
                  r = 1;
               }
               if(r < -1)
               {
                  r = -1;
               }
               out.writeFloat(l);
               out.writeFloat(r);
               i++;
            }
         }
         
         private function sampleSilence(sde:SampleDataEvent) : void {
            var i:uint = 0;
            while(i < SILENCE_SAMPLES_BUFFER_SIZE)
            {
               sde.data.writeFloat(0);
               sde.data.writeFloat(0);
               i++;
            }
         }
         
         private function directSoundComplete(e:Event) : void {
            var sw:SoundWrapper = this._directChannels[e.target];
            sw.currentLoop++;
            if((sw.currentLoop < sw.loops) || (sw.loops == 0))
            {
               this.directPlay(sw,sw.loops);
            }
            else
            {
               this.directStop(sw,true);
               sw.dispatchEvent(e);
            }
         }
         
         private function onEnterFrame(pEvent:Event) : void {
            var sw:SoundWrapper = null;
            for each (sw in this._directChannels)
            {
               sw.checkSoundPosition();
            }
         }
      }
   }
