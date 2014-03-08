package com.ankamagames.tubul.types
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import __AS3__.vec.Vector;
   import flash.utils.Dictionary;
   import flash.utils.ByteArray;
   import flash.events.Event;
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
      
      public function getSoundChannel(param1:SoundWrapper) : SoundChannel {
         return this._directlyPlayed[param1];
      }
      
      public function addSound(param1:SoundWrapper) : void {
         this.directPlay(param1,param1.loops);
      }
      
      public function removeSound(param1:SoundWrapper) : void {
         var _loc2_:int = this._sounds.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._sounds.splice(_loc2_,1);
            param1.dispatchEvent(new Event(Event.SOUND_COMPLETE));
            if(!--this._soundsCount)
            {
               this.setSilence(true);
            }
         }
         else
         {
            if(this._directlyPlayed[param1])
            {
               this.directStop(param1);
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
      
      private function setSilence(param1:Boolean) : void {
         if(param1)
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
      
      private function directPlay(param1:SoundWrapper, param2:int) : void {
         var _loc3_:SoundChannel = null;
         if(!StageShareManager.stage.hasEventListener(Event.ENTER_FRAME))
         {
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         _loc3_ = param1.sound.play(0,1,param1.getSoundTransform());
         if(_loc3_ == null)
         {
            _log.error("directChannel is null !");
            return;
         }
         if(this._directlyPlayed[param1] != null)
         {
            this._directChannels[this._directlyPlayed[param1]] = null;
            delete this._directChannels[[this._directlyPlayed[param1]]];
         }
         this._directlyPlayed[param1] = _loc3_;
         this._directChannels[_loc3_] = param1;
         if(!_loc3_.hasEventListener(Event.SOUND_COMPLETE))
         {
            _loc3_.addEventListener(Event.SOUND_COMPLETE,this.directSoundComplete);
         }
      }
      
      private function directStop(param1:SoundWrapper, param2:Boolean=false) : void {
         var _loc3_:SoundChannel = this._directlyPlayed[param1];
         _loc3_.removeEventListener(Event.SOUND_COMPLETE,this.directSoundComplete);
         _loc3_.stop();
         param1.currentLoop = 0;
         if(!param2)
         {
            param1.dispatchEvent(new Event(Event.SOUND_COMPLETE));
         }
         delete this._directlyPlayed[[param1]];
         delete this._directChannels[[_loc3_]];
         if((StageShareManager.stage.hasEventListener(Event.ENTER_FRAME)) && this._directChannels.length == 0)
         {
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      private function sampleData(param1:SampleDataEvent) : void {
         var _loc3_:uint = 0;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:ByteArray = null;
         var _loc14_:SoundWrapper = null;
         var _loc16_:* = false;
         var _loc17_:* = NaN;
         var _loc18_:* = NaN;
         var _loc19_:* = NaN;
         var _loc20_:* = NaN;
         var _loc21_:* = false;
         var _loc2_:uint = getTimer();
         var _loc15_:ByteArray = param1.data;
         _loc11_ = 0;
         while(_loc11_ < this._soundsCount)
         {
            _loc14_ = this._sounds[_loc11_] as SoundWrapper;
            if(!_loc14_._extractFinished)
            {
               _loc4_ = DATA_SAMPLES_BUFFER_SIZE;
               _loc3_ = _loc14_.soundData.position;
               _loc21_ = true;
               do
               {
                     if(_loc3_ == 0 && (_loc21_))
                     {
                        _loc5_ = _loc14_.sound.extract(_loc14_.soundData,_loc4_,0);
                     }
                     else
                     {
                        _loc5_ = _loc14_.sound.extract(_loc14_.soundData,_loc4_);
                     }
                     _loc21_ = false;
                     _loc16_ = !(_loc5_ == _loc4_);
                     if(!_loc14_.hadBeenCut && (_loc14_.loops == 0 || _loc14_.loops > 1))
                     {
                        _loc14_.currentLoop++;
                        _loc14_.soundData.position = _loc9_;
                        _loc10_ = 0;
                        while(_loc10_ < _loc5_)
                        {
                           _loc6_ = _loc14_.soundData.readFloat();
                           _loc7_ = _loc14_.soundData.readFloat();
                           if(_loc6_ > 0.001 || _loc6_ < -0.001 || _loc7_ > 0.001 || _loc7_ < -0.001)
                           {
                              _loc14_.hadBeenCut = true;
                              break;
                           }
                           _loc10_++;
                        }
                        _loc8_ = _loc10_ + 1;
                        _loc10_ = _loc10_ + 1;
                        while(_loc10_ < _loc5_)
                        {
                           this._cuttingBytes.writeFloat(_loc14_.soundData.readFloat());
                           this._cuttingBytes.writeFloat(_loc14_.soundData.readFloat());
                           _loc10_++;
                        }
                        if(this._cuttingBytes.length > 0)
                        {
                           _loc4_ = _loc4_ + _loc8_;
                           _loc13_ = _loc14_.soundData;
                           _loc14_.soundData = this._cuttingBytes;
                           this._cuttingBytes = _loc13_;
                           this._cuttingBytes.clear();
                        }
                        else
                        {
                           _loc9_ = _loc9_ + DATA_SAMPLES_BUFFER_SIZE * 8;
                           _loc4_ = _loc4_ + DATA_SAMPLES_BUFFER_SIZE;
                        }
                     }
                     if(_loc16_)
                     {
                        _loc14_.extractFinished();
                        break;
                     }
                     _loc4_ = _loc4_ - _loc5_;
                  }while(_loc4_ > 0);
                  
                  _loc14_.soundData.position = _loc3_;
               }
               _loc11_++;
            }
            _loc10_ = 0;
            while(_loc10_ < DATA_SAMPLES_BUFFER_SIZE)
            {
               _loc17_ = _loc18_ = 0.0;
               _loc11_ = 0;
               while(_loc11_ < this._soundsCount)
               {
                  if(_loc10_ == 0)
                  {
                     _loc14_.checkSoundPosition();
                  }
                  _loc14_ = this._sounds[_loc11_] as SoundWrapper;
                  if(_loc14_.soundData.bytesAvailable < 8)
                  {
                     if(_loc14_.loops == 0 || _loc14_.loops > 1 && _loc14_.currentLoop + 1 < _loc14_.loops)
                     {
                        _loc14_.soundData.position = 0;
                        _loc14_.currentLoop++;
                     }
                     else
                     {
                        this.removeSound(_loc14_);
                        break;
                     }
                  }
                  else
                  {
                     _loc19_ = _loc14_.soundData.readFloat() * _loc14_._volume * (1 - _loc14_._pan);
                     _loc20_ = _loc14_.soundData.readFloat() * _loc14_._volume * (1 + _loc14_._pan);
                     _loc17_ = _loc17_ + (_loc19_ * _loc14_._leftToLeft + _loc20_ * _loc14_._rightToLeft);
                     _loc18_ = _loc18_ + (_loc19_ * _loc14_._leftToRight + _loc20_ * _loc14_._rightToRight);
                  }
                  _loc11_++;
               }
               if(_loc17_ > 1)
               {
                  _loc17_ = 1;
               }
               if(_loc17_ < -1)
               {
                  _loc17_ = -1;
               }
               if(_loc18_ > 1)
               {
                  _loc18_ = 1;
               }
               if(_loc18_ < -1)
               {
                  _loc18_ = -1;
               }
               _loc15_.writeFloat(_loc17_);
               _loc15_.writeFloat(_loc18_);
               _loc10_++;
            }
         }
         
         private function sampleSilence(param1:SampleDataEvent) : void {
            var _loc2_:uint = 0;
            while(_loc2_ < SILENCE_SAMPLES_BUFFER_SIZE)
            {
               param1.data.writeFloat(0);
               param1.data.writeFloat(0);
               _loc2_++;
            }
         }
         
         private function directSoundComplete(param1:Event) : void {
            var _loc2_:SoundWrapper = this._directChannels[param1.target];
            _loc2_.currentLoop++;
            if(_loc2_.currentLoop < _loc2_.loops || _loc2_.loops == 0)
            {
               this.directPlay(_loc2_,_loc2_.loops);
            }
            else
            {
               this.directStop(_loc2_,true);
               _loc2_.dispatchEvent(param1);
            }
         }
         
         private function onEnterFrame(param1:Event) : void {
            var _loc2_:SoundWrapper = null;
            for each (_loc2_ in this._directChannels)
            {
               _loc2_.checkSoundPosition();
            }
         }
      }
   }
