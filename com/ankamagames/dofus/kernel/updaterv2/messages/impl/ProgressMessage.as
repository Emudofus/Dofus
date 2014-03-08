package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterInputMessage;
   
   public class ProgressMessage extends Object implements IUpdaterInputMessage
   {
      
      public function ProgressMessage() {
         super();
      }
      
      private var _step:String;
      
      private var _progress:Number;
      
      private var _smooth:Number;
      
      private var _eta:Number;
      
      private var _speed:Number;
      
      private var _currentSize:Number;
      
      private var _totalSize:Number;
      
      public function deserialize(param1:Object) : void {
         this._step = param1["step"];
         this._progress = param1["progress"];
         this._smooth = param1["smooth"];
         this._eta = param1["eta"];
         this._speed = param1["speed"];
         this._currentSize = param1["currentSize"];
         this._totalSize = param1["totalSize"];
      }
      
      public function get progress() : Number {
         return this._progress;
      }
      
      public function get smooth() : Number {
         return this._smooth;
      }
      
      public function get eta() : Number {
         return this._eta;
      }
      
      public function get speed() : Number {
         return this._speed;
      }
      
      public function get currentSize() : Number {
         return this._currentSize;
      }
      
      public function get totalSize() : Number {
         return this._totalSize;
      }
      
      public function get step() : String {
         return this._step;
      }
      
      public function toString() : String {
         return "[ProgressMessage step=" + this._step + " progress=" + this._progress + ", smooth=" + this._smooth + ", eta=" + this._eta + ", speed=" + this._speed + ", currentSize=" + this._currentSize + ", totalSize=" + this._totalSize + "]";
      }
   }
}
