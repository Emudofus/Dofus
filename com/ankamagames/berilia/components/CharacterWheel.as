package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.tiphon.types.ISubEntityBehavior;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.tiphon.types.ISkinModifier;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.sequence.SetAnimationStep;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.berilia.types.event.InstanceEvent;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.events.Event;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.enums.EventEnums;
   import com.ankamagames.berilia.managers.UIEventManager;
   import flash.geom.ColorTransform;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.messages.Message;
   import flash.display.DisplayObject;
   
   public class CharacterWheel extends GraphicContainer implements FinalizableUIComponent
   {
      
      public function CharacterWheel() {
         super();
         this._aEntitiesLook = new Array();
         this._aMountainsCtr = new Array();
         this._aSprites = new Array();
         this._ctrDepth = new Array();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacterWheel));
      
      private static const _animationModifier:Dictionary = new Dictionary();
      
      private static const _skinModifier:Dictionary = new Dictionary();
      
      private static const _subEntitiesBehaviors:Dictionary = new Dictionary();
      
      public static function setSubEntityDefaultBehavior(param1:uint, param2:ISubEntityBehavior) : void {
         _subEntitiesBehaviors[param1] = param2;
      }
      
      public static function setAnimationModifier(param1:uint, param2:IAnimationModifier) : void {
         _animationModifier[param1] = param2;
      }
      
      public static function setSkinModifier(param1:uint, param2:ISkinModifier) : void {
         _skinModifier[param1] = param2;
      }
      
      private var _nSelectedChara:int;
      
      private var _nNbCharacters:uint = 1;
      
      private var _aCharactersList:Object;
      
      private var _aEntitiesLook:Array;
      
      private var _ctrDepth:Array;
      
      private var _uiClass:UiRootContainer;
      
      private var _aMountainsCtr:Array;
      
      private var _aSprites:Array;
      
      private var _charaSelCtr:Object;
      
      private var _midZCtr:Object;
      
      private var _frontZCtr:Object;
      
      private var _sMountainUri:String;
      
      private var _nWidthEllipsis:int = 390;
      
      private var _nHeightEllipsis:int = 200;
      
      private var _nXCenterEllipsis:int = 540;
      
      private var _nYCenterEllipsis:int = 360;
      
      private var _nRotationStep:Number = 0;
      
      private var _nRotation:Number = 0;
      
      private var _nRotationPieceTrg:Number;
      
      private var _sens:int;
      
      private var _bMovingMountains:Boolean = false;
      
      private var _finalized:Boolean = false;
      
      private var _aRenderePartNames:Array;
      
      public function get widthEllipsis() : int {
         return this._nWidthEllipsis;
      }
      
      public function set widthEllipsis(param1:int) : void {
         this._nWidthEllipsis = param1;
      }
      
      public function get heightEllipsis() : int {
         return this._nHeightEllipsis;
      }
      
      public function set heightEllipsis(param1:int) : void {
         this._nHeightEllipsis = param1;
      }
      
      public function get xEllipsis() : int {
         return this._nXCenterEllipsis;
      }
      
      public function set xEllipsis(param1:int) : void {
         this._nXCenterEllipsis = param1;
      }
      
      public function get yEllipsis() : int {
         return this._nYCenterEllipsis;
      }
      
      public function set yEllipsis(param1:int) : void {
         this._nYCenterEllipsis = param1;
      }
      
      public function get charaCtr() : Object {
         return this._charaSelCtr;
      }
      
      public function set charaCtr(param1:Object) : void {
         this._charaSelCtr = param1;
      }
      
      public function get frontCtr() : Object {
         return this._frontZCtr;
      }
      
      public function set frontCtr(param1:Object) : void {
         this._frontZCtr = param1;
      }
      
      public function get midCtr() : Object {
         return this._midZCtr;
      }
      
      public function set midCtr(param1:Object) : void {
         this._midZCtr = param1;
      }
      
      public function get mountainUri() : String {
         return this._sMountainUri;
      }
      
      public function set mountainUri(param1:String) : void {
         this._sMountainUri = param1;
      }
      
      public function get selectedChara() : int {
         return this._nSelectedChara;
      }
      
      public function set selectedChara(param1:int) : void {
         this._nSelectedChara = param1;
      }
      
      public function get isWheeling() : Boolean {
         return this._bMovingMountains;
      }
      
      public function set entities(param1:*) : void {
         if(!this.isIterable(param1))
         {
            throw new ArgumentError("entities must be either Array or Vector.");
         }
         else
         {
            this._aEntitiesLook = SecureCenter.unsecure(param1);
            return;
         }
      }
      
      public function get entities() : * {
         return SecureCenter.secure(this._aEntitiesLook);
      }
      
      public function set dataProvider(param1:*) : void {
         if(!this.isIterable(param1))
         {
            throw new ArgumentError("dataProvider must be either Array or Vector.");
         }
         else
         {
            this._aCharactersList = param1;
            this.finalize();
            return;
         }
      }
      
      public function get dataProvider() : * {
         return this._aCharactersList;
      }
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      public function set finalized(param1:Boolean) : void {
         this._finalized = param1;
      }
      
      public function finalize() : void {
         this._uiClass = getUi();
         if(this._aCharactersList)
         {
            this._nNbCharacters = this._aCharactersList.length;
            this._nSelectedChara = 0;
            if(this._nNbCharacters > 0)
            {
               this.charactersDisplay();
            }
         }
         this._finalized = true;
         if(getUi())
         {
            getUi().iAmFinalized(this);
         }
      }
      
      override public function remove() : void {
         var _loc1_:GraphicContainer = null;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:ISubEntityBehavior = null;
         var _loc5_:TiphonEntity = null;
         var _loc6_:uint = 0;
         if(!__removed)
         {
            for each (_loc1_ in this._aMountainsCtr)
            {
               _loc1_.remove();
            }
            _loc2_ = this._aSprites.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc5_ = this._aSprites[_loc3_];
               _loc5_.destroy();
               _loc3_++;
            }
            if(this._charaSelCtr)
            {
               _loc6_ = this._charaSelCtr.numChildren;
               while(_loc6_ > 0)
               {
                  this._charaSelCtr.removeChildAt(0);
                  _loc6_--;
               }
            }
            this._aCharactersList = null;
            this._aEntitiesLook = null;
            this._ctrDepth = null;
            this._uiClass = null;
            this._aMountainsCtr = null;
            this._aSprites = null;
            this._charaSelCtr = null;
            this._midZCtr = null;
            this._frontZCtr = null;
            for each (_loc4_ in _subEntitiesBehaviors)
            {
               if(_loc4_)
               {
                  _loc4_.remove();
               }
            }
         }
         super.remove();
      }
      
      public function wheel(param1:int) : void {
         this.rotateMountains(param1);
      }
      
      public function wheelChara(param1:int) : void {
         var _loc2_:int = IAnimated(this._aSprites[this._nSelectedChara]).getDirection() + param1;
         _loc2_ = _loc2_ == 8?0:_loc2_;
         _loc2_ = _loc2_ < 0?7:_loc2_;
         IAnimated(this._aSprites[this._nSelectedChara]).setDirection(_loc2_);
         this.createMountainsCtrBitmap(this._aSprites[this._nSelectedChara].parent,this._nSelectedChara);
      }
      
      public function setAnimation(param1:String, param2:int=0) : void {
         var _loc3_:SerialSequencer = new SerialSequencer();
         var _loc4_:TiphonSprite = this._aSprites[this._nSelectedChara];
         if(param1 == "AnimStatique")
         {
            _loc4_.setAnimationAndDirection("AnimStatique",param2);
         }
         else
         {
            _loc3_.addStep(new SetDirectionStep(_loc4_,param2));
            _loc3_.addStep(new PlayAnimationStep(_loc4_,param1,false));
            _loc3_.addStep(new SetAnimationStep(_loc4_,"AnimStatique"));
            _loc3_.start();
         }
      }
      
      public function equipCharacter(param1:Array, param2:int=0) : void {
         var _loc6_:Array = null;
         var _loc7_:* = 0;
         var _loc3_:TiphonSprite = this._aSprites[this._nSelectedChara];
         var _loc4_:Array = _loc3_.look.toString().split("|");
         if(param1.length)
         {
            param1.unshift(_loc4_[1].split(","));
            _loc4_[1] = param1.join(",");
         }
         else
         {
            _loc6_ = _loc4_[1].split(",");
            _loc7_ = 0;
            while(_loc7_ < param2)
            {
               _loc6_.pop();
               _loc7_++;
            }
            _loc4_[1] = _loc6_.join(",");
         }
         var _loc5_:TiphonEntityLook = TiphonEntityLook.fromString(_loc4_.join("|"));
         _loc3_.look.updateFrom(_loc5_);
      }
      
      public function getMountainCtr(param1:int) : Object {
         return this._aMountainsCtr[param1];
      }
      
      private function charactersDisplay() : void {
         var _loc3_:GraphicContainer = null;
         var _loc4_:TiphonEntity = null;
         var _loc5_:uint = 0;
         var _loc6_:* = 0;
         var _loc7_:* = NaN;
         var _loc8_:* = 0;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:GraphicContainer = null;
         var _loc12_:CBI = null;
         var _loc13_:TiphonEntity = null;
         var _loc14_:* = undefined;
         var _loc15_:Texture = null;
         var _loc16_:InstanceEvent = null;
         var _loc1_:int = this._aSprites.length;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = this._aSprites.shift();
            _loc4_.destroy();
            _loc2_++;
         }
         for each (_loc3_ in this._aMountainsCtr)
         {
            _loc3_.remove();
         }
         if(this._aMountainsCtr.length > 0)
         {
            _loc5_ = this._aMountainsCtr.numChildren;
            _loc6_ = _loc5_-1;
            while(_loc6_ >= 0)
            {
               this._aMountainsCtr.removeChild(this._aMountainsCtr.getChildAt(_loc6_));
               _loc6_--;
            }
            this._aMountainsCtr = new Array();
            this._ctrDepth = new Array();
         }
         if(this._nNbCharacters == 0)
         {
            _log.error("Error : The character list is empty.");
         }
         else
         {
            _loc7_ = 2 * Math.PI / this._nNbCharacters;
            this._nRotation = 0;
            this._nRotationPieceTrg = 0;
            this._aRenderePartNames = new Array();
            _loc8_ = 0;
            while(_loc8_ < this._nNbCharacters)
            {
               if(this._aCharactersList[_loc8_])
               {
                  _loc9_ = _loc7_ * _loc8_ % (2 * Math.PI);
                  _loc10_ = Math.abs(_loc9_ - Math.PI) / Math.PI;
                  _loc11_ = new GraphicContainer();
                  _loc11_.x = this._nWidthEllipsis * Math.cos(_loc9_ + Math.PI / 2) + this._nXCenterEllipsis;
                  _loc11_.y = this._nHeightEllipsis * Math.sin(_loc9_ + Math.PI / 2) + this._nYCenterEllipsis;
                  _loc12_ = new CBI(this._aCharactersList[_loc8_].id,this._aCharactersList[_loc8_].breedId,new Array());
                  this._aEntitiesLook[_loc8_].look = SecureCenter.unsecure(this._aEntitiesLook[_loc8_].look);
                  _loc13_ = new TiphonEntity(this._aEntitiesLook[_loc8_].id,this._aEntitiesLook[_loc8_].look);
                  _loc11_.addChild(_loc13_);
                  _loc13_.name = "char" + _loc8_;
                  _loc13_.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onMoutainPartRendered);
                  if(_animationModifier[_loc13_.look.getBone()])
                  {
                     _loc13_.addAnimationModifier(_animationModifier[_loc13_.look.getBone()]);
                  }
                  if(_skinModifier[_loc13_.look.getBone()])
                  {
                     _loc13_.skinModifier = _skinModifier[_loc13_.look.getBone()];
                  }
                  for (_loc14_ in _subEntitiesBehaviors)
                  {
                     if(_subEntitiesBehaviors[_loc14_])
                     {
                        _loc13_.setSubEntityBehaviour(_loc14_,_subEntitiesBehaviors[_loc14_]);
                     }
                  }
                  if(_loc13_.look.getBone() == 1)
                  {
                     _loc13_.setAnimationAndDirection("AnimStatique",2);
                  }
                  else
                  {
                     _loc13_.setAnimationAndDirection("AnimStatique",3);
                  }
                  _loc13_.x = -5;
                  _loc13_.y = -64;
                  _loc13_.scaleX = 2.2;
                  _loc13_.scaleY = 2.2;
                  _loc13_.cacheAsBitmap = true;
                  this._aSprites[_loc8_] = _loc13_;
                  _loc11_.scaleX = _loc11_.scaleY = Math.max(0.3,_loc10_);
                  _loc11_.alpha = Math.max(0.3,_loc10_);
                  _loc11_.useHandCursor = true;
                  _loc11_.buttonMode = true;
                  if(this._nNbCharacters == 2)
                  {
                     if(_loc8_ == 1)
                     {
                        _loc11_.x = this._nWidthEllipsis * Math.cos(_loc9_ + Math.PI / 6 + Math.PI / 2) + this._nXCenterEllipsis;
                        _loc11_.y = this._nHeightEllipsis * Math.sin(_loc9_ + Math.PI / 6 + Math.PI / 2) + this._nYCenterEllipsis;
                     }
                  }
                  if(this._nNbCharacters == 4)
                  {
                     if(_loc8_ == 2)
                     {
                        _loc11_.x = this._nWidthEllipsis * Math.cos(_loc9_ + Math.PI / 6 + Math.PI / 2) + this._nXCenterEllipsis;
                        _loc11_.y = this._nHeightEllipsis * Math.sin(_loc9_ + Math.PI / 6 + Math.PI / 2) + this._nYCenterEllipsis;
                     }
                  }
                  _loc15_ = new Texture();
                  _loc11_.addChildAt(_loc15_,0);
                  _loc15_.name = "char" + _loc8_;
                  _loc15_.dispatchMessages = true;
                  _loc15_.addEventListener(Event.COMPLETE,this.onMoutainPartRendered);
                  _loc15_.scale = 1.2;
                  _loc15_.y = -62;
                  _loc15_.uri = new Uri(this._sMountainUri + "assets.swf|base_" + _loc12_.breed);
                  _loc15_.finalize();
                  _loc16_ = new InstanceEvent(_loc11_,this._uiClass.uiClass);
                  _loc16_.push(EventEnums.EVENT_ONRELEASE_MSG);
                  _loc16_.push(EventEnums.EVENT_ONDOUBLECLICK_MSG);
                  UIEventManager.getInstance().registerInstance(_loc16_);
                  if(_loc8_ == 0)
                  {
                     this._charaSelCtr.addChild(this._midZCtr);
                  }
                  if(this._aEntitiesLook[_loc8_].disabled)
                  {
                     _loc11_.transform.colorTransform = new ColorTransform(0.6,0.6,0.6,1);
                  }
                  this._charaSelCtr.addChild(_loc11_);
                  this._ctrDepth.push(this._charaSelCtr.getChildIndex(_loc11_));
                  this._aMountainsCtr[_loc8_] = _loc11_;
               }
               _loc8_++;
            }
            this._charaSelCtr.addChild(this._frontZCtr);
         }
      }
      
      private function onMoutainPartRendered(param1:Event) : void {
         if(param1.type == TiphonEvent.RENDER_SUCCEED)
         {
            param1.target.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onMoutainPartRendered);
         }
         else
         {
            if(param1.type == Event.COMPLETE)
            {
               param1.target.removeEventListener(Event.COMPLETE,this.onMoutainPartRendered);
            }
         }
         if((this._aRenderePartNames[param1.target.name]) && (param1.target.stage))
         {
            this.createMountainsCtrBitmap(this._aRenderePartNames[param1.target.name],int(param1.target.name.replace("char","")));
         }
         else
         {
            this._aRenderePartNames[param1.target.name] = param1.target.parent;
         }
      }
      
      private function createMountainsCtrBitmap(param1:GraphicContainer, param2:int) : void {
         var _loc5_:Bitmap = null;
         var _loc3_:Number = param1.alpha;
         param1.alpha = 1;
         var _loc4_:Number = param1.scaleX;
         param1.scaleX = param1.scaleY = 1;
         if(param1.numChildren > 2)
         {
            _loc5_ = param1.getChildAt(2) as Bitmap;
            if((_loc5_) && (_loc5_.bitmapData))
            {
               _loc5_.bitmapData.dispose();
            }
         }
         var _loc6_:Rectangle = param1.getBounds(param1);
         var _loc7_:BitmapData = new BitmapData(_loc6_.width,_loc6_.height,true,5596808);
         _loc7_.draw(param1,new Matrix(1,0,0,1,-_loc6_.x,-_loc6_.y));
         if(!_loc5_)
         {
            _loc5_ = new Bitmap(_loc7_,"auto",true);
         }
         else
         {
            _loc5_.bitmapData = _loc7_;
         }
         _loc5_.x = _loc6_.x;
         _loc5_.y = _loc6_.y;
         param1.alpha = _loc3_;
         param1.scaleX = param1.scaleY = _loc4_;
         param1.addChild(_loc5_);
         if(param1.numChildren == 3)
         {
            param1.getChildAt(0).visible = param1.getChildAt(1).visible = param2 == this._nSelectedChara;
            param1.getChildAt(2).visible = !(param2 == this._nSelectedChara);
         }
      }
      
      private function endRotationMountains() : void {
         EnterFrameDispatcher.removeEventListener(this.onRotateMountains);
         this._bMovingMountains = false;
      }
      
      private function rotateMountains(param1:int) : void {
         var _loc3_:IInterfaceListener = null;
         var _loc4_:IInterfaceListener = null;
         this._nSelectedChara = this._nSelectedChara - param1;
         if(this._nSelectedChara >= this._aCharactersList.length)
         {
            this._nSelectedChara = this._nSelectedChara - this._aCharactersList.length;
         }
         if(this._nSelectedChara < 0)
         {
            this._nSelectedChara = this._aCharactersList.length + this._nSelectedChara;
         }
         var _loc2_:Number = 2 * Math.PI / this._nNbCharacters;
         this._sens = param1;
         this._nRotationStep = _loc2_;
         if(isNaN(this._nRotationPieceTrg))
         {
            this._nRotationPieceTrg = this._nRotation + this._nRotationStep * this._sens;
         }
         else
         {
            this._nRotationPieceTrg = this._nRotationPieceTrg + this._nRotationStep * this._sens;
         }
         if(param1 == 1)
         {
            for each (_loc3_ in Berilia.getInstance().UISoundListeners)
            {
               _loc3_.playUISound("16079");
            }
         }
         else
         {
            for each (_loc4_ in Berilia.getInstance().UISoundListeners)
            {
               _loc4_.playUISound("16080");
            }
         }
         EnterFrameDispatcher.addEventListener(this.onRotateMountains,"mountainsRotation",StageShareManager.stage.frameRate);
      }
      
      private function isIterable(param1:*) : Boolean {
         if(param1 is Array)
         {
            return true;
         }
         if(!(param1["length"] == null) && !(param1["length"] == 0) && !isNaN(param1["length"]) && !(param1[0] == null) && !(param1 is String))
         {
            return true;
         }
         return false;
      }
      
      override public function process(param1:Message) : Boolean {
         return false;
      }
      
      public function eventOnRelease(param1:DisplayObject) : void {
      }
      
      public function eventOnDoubleClick(param1:DisplayObject) : void {
         if(this._bMovingMountains)
         {
         }
      }
      
      public function eventOnRollOver(param1:DisplayObject) : void {
      }
      
      public function eventOnRollOut(param1:DisplayObject) : void {
      }
      
      public function eventOnShortcut(param1:String) : Boolean {
         return false;
      }
      
      private function onRotateMountains(param1:Event) : void {
         var _loc4_:GraphicContainer = null;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         this._bMovingMountains = true;
         if(this._nRotationStep == 0)
         {
            this.endRotationMountains();
         }
         if(Math.abs(this._nRotationPieceTrg - this._nRotation) < 0.01)
         {
            this._nRotation = this._nRotationPieceTrg;
         }
         else
         {
            this._nRotation = this._nRotation + (this._nRotationPieceTrg - this._nRotation) / 3;
         }
         var _loc2_:Array = new Array();
         var _loc3_:* = 0;
         for each (_loc4_ in this._aMountainsCtr)
         {
            _loc5_ = (this._nRotation + this._nRotationStep * _loc3_) % (2 * Math.PI);
            _loc6_ = Math.abs(Math.PI - (_loc5_ < 0?_loc5_ + 2 * Math.PI:_loc5_) % (2 * Math.PI)) / Math.PI;
            _loc2_.push(
               {
                  "ctr":_loc4_,
                  "z":_loc6_
               });
            _loc4_.x = this._nWidthEllipsis * Math.cos(_loc5_ + Math.PI / 2) + this._nXCenterEllipsis;
            _loc4_.y = this._nHeightEllipsis * Math.sin(_loc5_ + Math.PI / 2) + this._nYCenterEllipsis;
            if(this._nNbCharacters == 2)
            {
               if(_loc4_.y < 300)
               {
                  _loc4_.x = this._nWidthEllipsis * Math.cos(_loc5_ + Math.PI / 6 + Math.PI / 2) + this._nXCenterEllipsis;
                  _loc4_.y = this._nHeightEllipsis * Math.sin(_loc5_ + Math.PI / 6 + Math.PI / 2) + this._nYCenterEllipsis;
               }
            }
            if(this._nNbCharacters == 4)
            {
               if(_loc4_.y < 300)
               {
                  _loc4_.x = this._nWidthEllipsis * Math.cos(_loc5_ + Math.PI / 6 + Math.PI / 2) + this._nXCenterEllipsis;
                  _loc4_.y = this._nHeightEllipsis * Math.sin(_loc5_ + Math.PI / 6 + Math.PI / 2) + this._nYCenterEllipsis;
               }
            }
            _loc4_.scaleX = _loc4_.scaleY = Math.max(0.3,_loc6_);
            _loc4_.alpha = Math.max(0.3,_loc6_);
            if(_loc4_.numChildren == 3)
            {
               _loc4_.getChildAt(0).visible = _loc4_.getChildAt(1).visible = _loc3_ == this._nSelectedChara;
               _loc4_.getChildAt(2).visible = !(_loc3_ == this._nSelectedChara);
            }
            _loc3_++;
         }
         _loc2_.sortOn("z",Array.NUMERIC);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc2_[_loc3_].ctr.parent.addChildAt(_loc2_[_loc3_].ctr,this._ctrDepth[_loc3_]);
            _loc3_++;
         }
         if(this._charaSelCtr)
         {
            this._charaSelCtr.setChildIndex(this._frontZCtr,this._charaSelCtr.numChildren-1);
         }
         if(this._nRotationPieceTrg == this._nRotation)
         {
            this.endRotationMountains();
         }
      }
   }
}
import com.ankamagames.tiphon.display.TiphonSprite;
import com.ankamagames.jerakine.entities.interfaces.IEntity;
import com.ankamagames.jerakine.types.positions.MapPoint;
import com.ankamagames.tiphon.types.look.TiphonEntityLook;

class TiphonEntity extends TiphonSprite implements IEntity
{
   
   function TiphonEntity(param1:uint, param2:TiphonEntityLook) {
      super(param2);
      this._id = param1;
      mouseEnabled = false;
      mouseChildren = false;
   }
   
   private var _id:uint;
   
   public function get id() : int {
      return this._id;
   }
   
   public function set id(param1:int) : void {
      this._id = param1;
   }
   
   public function get position() : MapPoint {
      return null;
   }
   
   public function set position(param1:MapPoint) : void {
   }
}
class CBI extends Object
{
   
   function CBI(param1:uint, param2:int, param3:Array) {
      this.colors = new Array();
      super();
      this.id = param1;
      this.breed = param2;
      this.colors = param3;
   }
   
   public var id:int;
   
   public var gfxId:int;
   
   public var breed:int;
   
   public var colors:Array;
}
