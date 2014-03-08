package com.ankamagames.tubul.types
{
   import flash.events.EventDispatcher;
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import com.ankamagames.tubul.events.LoopEvent;
   import flash.media.SoundChannel;
   import com.ankamagames.tubul.Tubul;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   import com.ankamagames.tubul.events.SoundWrapperEvent;
   
   public class SoundWrapper extends EventDispatcher
   {
      
      public function SoundWrapper(snd:Sound, loops:int=1) {
         super();
         this._snd = snd;
         this._loops = loops;
         this._length = snd.length;
         this.currentLoop = 0;
         if(this._snd != null)
         {
            this._duration = Math.floor(this._snd.length) / 1000;
         }
      }
      
      private var _currentLoop:uint;
      
      private var _snd:Sound;
      
      private var _loops:int;
      
      private var _length:Number;
      
      private var _stDic:Dictionary;
      
      private var _duration:Number;
      
      private var _endOfFileEventDispatched:Boolean = false;
      
      private var _notify:Boolean = false;
      
      private var _notifyTime:Number;
      
      var _volume:Number = 1;
      
      var _leftToLeft:Number = 1;
      
      var _rightToLeft:Number = 0;
      
      var _rightToRight:Number = 1;
      
      var _leftToRight:Number = 0;
      
      var _pan:Number = 0;
      
      public function get currentLoop() : uint {
         return this._currentLoop;
      }
      
      public function set currentLoop(pLoop:uint) : void {
         this._currentLoop = pLoop;
         var e:LoopEvent = new LoopEvent(LoopEvent.SOUND_LOOP);
         e.loop = this._currentLoop;
         e.sound = this;
         dispatchEvent(e);
      }
      
      public function get position() : Number {
         var sc:SoundChannel = null;
         if((this.soundData == null) && (this.sound == null))
         {
            return -1;
         }
         var pos:Number = 0;
         if(this.soundData != null)
         {
            pos = Math.round(this.soundData.position / (8 * 44.1)) / 1000;
         }
         else
         {
            sc = Tubul.getInstance().soundMerger.getSoundChannel(this);
            if(sc != null)
            {
               pos = Math.round(sc.position) / 1000;
            }
         }
         return pos;
      }
      
      public function get duration() : Number {
         return this._duration;
      }
      
      public function get sound() : Sound {
         return this._snd;
      }
      
      public function get loops() : int {
         return this._loops;
      }
      
      public function set loops(pLoops:int) : void {
         this._loops = pLoops;
      }
      
      public function get length() : Number {
         return this._length;
      }
      
      public function get volume() : Number {
         return this._volume;
      }
      
      public function set volume(v:Number) : void {
         this._volume = v;
         var st:SoundTransform = this.getSoundTransform();
         st.volume = this._volume;
         this.applySoundTransform(st);
      }
      
      public function get leftToLeft() : Number {
         return this._leftToLeft;
      }
      
      public function set leftToLeft(v:Number) : void {
         this._leftToLeft = v;
         var st:SoundTransform = this.getSoundTransform();
         st.leftToLeft = this._leftToLeft;
         this.applySoundTransform(st);
      }
      
      public function get rightToLeft() : Number {
         return this._rightToLeft;
      }
      
      public function set rightToLeft(v:Number) : void {
         this._rightToLeft = v;
         var st:SoundTransform = this.getSoundTransform();
         st.rightToLeft = this._rightToLeft;
         this.applySoundTransform(st);
      }
      
      public function get rightToRight() : Number {
         return this._rightToRight;
      }
      
      public function set rightToRight(v:Number) : void {
         this._rightToRight = v;
         var st:SoundTransform = this.getSoundTransform();
         st.rightToRight = this._rightToRight;
         this.applySoundTransform(st);
      }
      
      public function get leftToRight() : Number {
         return this._leftToRight;
      }
      
      public function set leftToRight(v:Number) : void {
         this._leftToRight = v;
         var st:SoundTransform = this.getSoundTransform();
         st.leftToRight = this._leftToRight;
         this.applySoundTransform(st);
      }
      
      public function get pan() : Number {
         return this._pan;
      }
      
      public function set pan(v:Number) : void {
         this._pan = v;
         var st:SoundTransform = this.getSoundTransform();
         st.pan = this._pan;
         this.applySoundTransform(st);
      }
      
      var soundData:ByteArray;
      
      var hadBeenCut:Boolean;
      
      var _extractFinished:Boolean;
      
      function extractFinished() : void {
         this._extractFinished = true;
         this._snd = null;
      }
      
      public function checkSoundPosition() : void {
         var swe:SoundWrapperEvent = null;
         if(this._notify == false)
         {
            return;
         }
         if(this.duration - this.position < this._notifyTime + 0.5)
         {
            if((this.currentLoop == this._loops - 1) && (this._endOfFileEventDispatched == false))
            {
               swe = new SoundWrapperEvent(SoundWrapperEvent.SOON_END_OF_FILE);
               dispatchEvent(swe);
               this._endOfFileEventDispatched = true;
            }
         }
         else
         {
            this._endOfFileEventDispatched = false;
         }
      }
      
      public function getSoundTransform() : SoundTransform {
         var stInDic:* = undefined;
         if(this._stDic)
         {
            for (stInDic in this._stDic)
            {
               return stInDic;
            }
         }
         if(!this._stDic)
         {
            this._stDic = new Dictionary(true);
         }
         var st:SoundTransform = new SoundTransform(this._volume,this._pan);
         st.leftToLeft = this._leftToLeft;
         st.leftToRight = this._leftToRight;
         st.rightToLeft = this._rightToLeft;
         st.rightToRight = this._rightToRight;
         this._stDic[st] = true;
         return st;
      }
      
      public function notifyWhenEndOfFile(pNotify:Boolean=false, pTime:Number=-1) : void {
         this._notify = pNotify;
         if((pNotify) && (pTime <= 0))
         {
            this._notify = false;
            return;
         }
         this._notifyTime = pTime;
      }
      
      private function applySoundTransform(st:SoundTransform) : void {
         var soundChannel:SoundChannel = Tubul.getInstance().soundMerger.getSoundChannel(this);
         if(soundChannel != null)
         {
            soundChannel.soundTransform = st;
         }
      }
   }
}
