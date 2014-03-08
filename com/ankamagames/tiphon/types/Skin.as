package com.ankamagames.tiphon.types
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.jerakine.data.CensoredContentManager;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tiphon.TiphonConstants;
   import com.ankamagames.jerakine.types.Callback;
   import flash.display.Sprite;
   import com.ankamagames.jerakine.types.Swl;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   
   public class Skin extends EventDispatcher
   {
      
      public function Skin() {
         this._partTransformData = new Dictionary();
         this._transformData = new Dictionary();
         super();
         this._partToSwl = new Dictionary();
         this._skinParts = new Array();
         this._skinClass = new Array();
         this._aSkinPartOrdered = new Array();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(Skin));
      
      private static var _censoredSkin:Dictionary;
      
      private static var _alternativeSkin:Dictionary = new Dictionary();
      
      public static var skinPartTransformProvider:ISkinPartTransformProvider;
      
      public static function addAlternativeSkin(param1:uint, param2:uint) : void {
         if(!_alternativeSkin[param1])
         {
            _alternativeSkin[param1] = new Array();
         }
         _alternativeSkin[param1].push(param2);
      }
      
      private var _ressourceCount:uint = 0;
      
      private var _ressourceLoading:uint = 0;
      
      private var _partToSwl:Dictionary;
      
      private var _skinParts:Array;
      
      private var _skinClass:Array;
      
      private var _aSkinPartOrdered:Array;
      
      private var _validate:Boolean = true;
      
      private var _partTransformData:Dictionary;
      
      private var _transformData:Dictionary;
      
      public function get skinList() : Array {
         return this._aSkinPartOrdered;
      }
      
      public function get complete() : Boolean {
         var _loc2_:uint = 0;
         if(!this._validate)
         {
            return false;
         }
         var _loc1_:* = true;
         for each (_loc2_ in this._aSkinPartOrdered)
         {
            _loc1_ = (_loc1_) && ((Tiphon.skinLibrary.isLoaded(_loc2_)) || (Tiphon.skinLibrary.hasError(_loc2_)));
         }
         return _loc1_;
      }
      
      public function get validate() : Boolean {
         return this._validate;
      }
      
      public function set validate(param1:Boolean) : void {
         this._validate = param1;
         if((param1) && (this.complete))
         {
            this.processSkin();
         }
      }
      
      public function reprocess() : void {
         this.processSkin();
      }
      
      public function getSwlFromPart(param1:String) : uint {
         return this._partToSwl[param1];
      }
      
      public function add(param1:uint, param2:int=-1) : uint {
         var _loc3_:* = -1;
         if(!_censoredSkin)
         {
            _censoredSkin = CensoredContentManager.getInstance().getCensoredIndex(2);
         }
         if(_censoredSkin[param1])
         {
            param1 = _censoredSkin[param1];
         }
         if((!(param2 == -1)) && (_alternativeSkin) && (_alternativeSkin[param1]) && param2 < _alternativeSkin[param1].length)
         {
            _loc3_ = param1;
            param1 = _alternativeSkin[param1][param2];
         }
         var _loc4_:Array = new Array();
         var _loc5_:uint = 0;
         while(_loc5_ < this._aSkinPartOrdered.length)
         {
            if(!(this._aSkinPartOrdered[_loc5_] == param1) && !(this._aSkinPartOrdered[_loc5_] == _loc3_))
            {
               _loc4_.push(this._aSkinPartOrdered[_loc5_]);
            }
            _loc5_++;
         }
         _loc4_.push(param1);
         if(this._aSkinPartOrdered.length != _loc4_.length)
         {
            this._aSkinPartOrdered = _loc4_;
            this._ressourceLoading++;
            Tiphon.skinLibrary.addResource(param1,new Uri(TiphonConstants.SWF_SKIN_PATH + param1 + ".swl"));
            Tiphon.skinLibrary.askResource(param1,null,new Callback(this.onResourceLoaded,param1),new Callback(this.onResourceLoaded,param1));
         }
         else
         {
            this._aSkinPartOrdered = _loc4_;
         }
         return param1;
      }
      
      public function getTransformData(param1:String) : TransformData {
         return this._transformData[param1];
      }
      
      public function getPart(param1:String) : Sprite {
         var _loc2_:TransformData = this._transformData[param1];
         if((_loc2_) && (_loc2_.overrideClip))
         {
            if(_loc2_.overrideClip != param1)
            {
               return null;
            }
            param1 = _loc2_.originalClip;
         }
         var _loc3_:Sprite = this._skinParts[param1];
         if((_loc3_) && !_loc3_.parent)
         {
            if(_loc2_)
            {
               _loc3_.x = _loc2_.x;
               _loc3_.y = _loc2_.y;
               _loc3_.scaleX = _loc2_.scaleX;
               _loc3_.scaleY = _loc2_.scaleY;
               _loc3_.rotation = _loc2_.rotation;
            }
            else
            {
               _loc3_.x = 0.0;
               _loc3_.y = 0.0;
               _loc3_.scaleX = 1;
               _loc3_.scaleY = 1;
               _loc3_.rotation = 0.0;
            }
            return _loc3_;
         }
         if(this._skinClass[param1])
         {
            _loc3_ = new this._skinClass[param1]();
            if((_loc2_) && (_loc3_))
            {
               _loc3_.x = _loc2_.x;
               _loc3_.y = _loc2_.y;
               _loc3_.scaleX = _loc2_.scaleX;
               _loc3_.scaleY = _loc2_.scaleY;
               _loc3_.rotation = _loc2_.rotation;
            }
            this._skinParts[param1] = _loc3_;
            return _loc3_;
         }
         return null;
      }
      
      public function reset() : void {
         this._skinParts = new Array();
         this._skinClass = new Array();
         this._aSkinPartOrdered = new Array();
      }
      
      public function addTransform(param1:String, param2:uint, param3:TransformData) : void {
         if(!this._partTransformData[param1])
         {
            this._partTransformData[param1] = new Dictionary();
         }
         this._partTransformData[param1][param2] = param3;
      }
      
      private function onResourceLoaded(param1:uint) : void {
         this._ressourceCount++;
         this._ressourceLoading--;
         this.processSkin();
      }
      
      private function processSkin() : void {
         var _loc1_:uint = 0;
         var _loc3_:Swl = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Dictionary = null;
         var _loc8_:* = 0;
         var _loc9_:TransformData = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this._aSkinPartOrdered.length)
         {
            _loc1_ = this._aSkinPartOrdered[_loc2_];
            _loc3_ = Tiphon.skinLibrary.getResourceById(_loc1_);
            if(_loc3_)
            {
               _loc4_ = _loc3_.getDefinitions();
               for each (_loc5_ in _loc4_)
               {
                  this._skinClass[_loc5_] = _loc3_.getDefinition(_loc5_);
                  this._partToSwl[_loc5_] = _loc1_;
                  delete this._skinParts[[_loc5_]];
               }
            }
            _loc2_++;
         }
         if(this.complete)
         {
            this._partTransformData = new Dictionary();
            this._transformData = new Dictionary();
            if(skinPartTransformProvider)
            {
               skinPartTransformProvider.init(this);
               for (_loc6_ in this._skinClass)
               {
                  if(this._partTransformData[_loc6_])
                  {
                     _loc7_ = this._partTransformData[_loc6_];
                     _loc8_ = this._aSkinPartOrdered.length-1;
                     while(_loc8_ >= -1)
                     {
                        _loc1_ = _loc8_ >= 0?this._aSkinPartOrdered[_loc8_]:0;
                        if(_loc7_[_loc1_])
                        {
                           _loc9_ = _loc7_[_loc1_];
                           this._transformData[_loc6_] = _loc9_;
                           if(_loc9_.overrideClip)
                           {
                              this._transformData[_loc9_.overrideClip] = _loc9_;
                           }
                           break;
                        }
                        _loc8_--;
                     }
                  }
               }
            }
            dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            dispatchEvent(new Event(ProgressEvent.PROGRESS));
         }
      }
   }
}
