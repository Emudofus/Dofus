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
      
      protected static const _log:Logger;
      
      private static const _animationModifier:Dictionary;
      
      private static const _skinModifier:Dictionary;
      
      private static const _subEntitiesBehaviors:Dictionary;
      
      public static function setSubEntityDefaultBehavior(category:uint, behavior:ISubEntityBehavior) : void {
         _subEntitiesBehaviors[category] = behavior;
      }
      
      public static function setAnimationModifier(boneId:uint, am:IAnimationModifier) : void {
         _animationModifier[boneId] = am;
      }
      
      public static function setSkinModifier(boneId:uint, sm:ISkinModifier) : void {
         _skinModifier[boneId] = sm;
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
      
      public function set widthEllipsis(i:int) : void {
         this._nWidthEllipsis = i;
      }
      
      public function get heightEllipsis() : int {
         return this._nHeightEllipsis;
      }
      
      public function set heightEllipsis(i:int) : void {
         this._nHeightEllipsis = i;
      }
      
      public function get xEllipsis() : int {
         return this._nXCenterEllipsis;
      }
      
      public function set xEllipsis(i:int) : void {
         this._nXCenterEllipsis = i;
      }
      
      public function get yEllipsis() : int {
         return this._nYCenterEllipsis;
      }
      
      public function set yEllipsis(i:int) : void {
         this._nYCenterEllipsis = i;
      }
      
      public function get charaCtr() : Object {
         return this._charaSelCtr;
      }
      
      public function set charaCtr(ctr:Object) : void {
         this._charaSelCtr = ctr;
      }
      
      public function get frontCtr() : Object {
         return this._frontZCtr;
      }
      
      public function set frontCtr(ctr:Object) : void {
         this._frontZCtr = ctr;
      }
      
      public function get midCtr() : Object {
         return this._midZCtr;
      }
      
      public function set midCtr(ctr:Object) : void {
         this._midZCtr = ctr;
      }
      
      public function get mountainUri() : String {
         return this._sMountainUri;
      }
      
      public function set mountainUri(s:String) : void {
         this._sMountainUri = s;
      }
      
      public function get selectedChara() : int {
         return this._nSelectedChara;
      }
      
      public function set selectedChara(i:int) : void {
         this._nSelectedChara = i;
      }
      
      public function get isWheeling() : Boolean {
         return this._bMovingMountains;
      }
      
      public function set entities(data:*) : void {
         if(!this.isIterable(data))
         {
            throw new ArgumentError("entities must be either Array or Vector.");
         }
         else
         {
            this._aEntitiesLook = SecureCenter.unsecure(data);
            return;
         }
      }
      
      public function get entities() : * {
         return SecureCenter.secure(this._aEntitiesLook);
      }
      
      public function set dataProvider(data:*) : void {
         if(!this.isIterable(data))
         {
            throw new ArgumentError("dataProvider must be either Array or Vector.");
         }
         else
         {
            this._aCharactersList = data;
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
      
      public function set finalized(b:Boolean) : void {
         this._finalized = b;
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
         var g:GraphicContainer = null;
         var num:* = 0;
         var i:* = 0;
         var behavior:ISubEntityBehavior = null;
         var tiphonEntity:TiphonEntity = null;
         var numChildrenCtr:uint = 0;
         if(!__removed)
         {
            for each(g in this._aMountainsCtr)
            {
               g.remove();
            }
            num = this._aSprites.length;
            i = 0;
            while(i < num)
            {
               tiphonEntity = this._aSprites[i];
               tiphonEntity.destroy();
               i++;
            }
            if(this._charaSelCtr)
            {
               numChildrenCtr = this._charaSelCtr.numChildren;
               while(numChildrenCtr > 0)
               {
                  this._charaSelCtr.removeChildAt(0);
                  numChildrenCtr--;
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
            for each(behavior in _subEntitiesBehaviors)
            {
               if(behavior)
               {
                  behavior.remove();
               }
            }
         }
         super.remove();
      }
      
      public function wheel(sens:int) : void {
         this.rotateMountains(sens);
      }
      
      public function wheelChara(sens:int) : void {
         var dir:int = IAnimated(this._aSprites[this._nSelectedChara]).getDirection() + sens;
         dir = dir == 8?0:dir;
         dir = dir < 0?7:dir;
         IAnimated(this._aSprites[this._nSelectedChara]).setDirection(dir);
         this.createMountainsCtrBitmap(this._aSprites[this._nSelectedChara].parent,this._nSelectedChara);
      }
      
      public function setAnimation(animationName:String, direction:int = 0) : void {
         var seq:SerialSequencer = new SerialSequencer();
         var sprite:TiphonSprite = this._aSprites[this._nSelectedChara];
         if(animationName == "AnimStatique")
         {
            sprite.setAnimationAndDirection("AnimStatique",direction);
         }
         else
         {
            seq.addStep(new SetDirectionStep(sprite,direction));
            seq.addStep(new PlayAnimationStep(sprite,animationName,false));
            seq.addStep(new SetAnimationStep(sprite,"AnimStatique"));
            seq.start();
         }
      }
      
      public function equipCharacter(list:Array, numDelete:int = 0) : void {
         var bones:Array = null;
         var k:* = 0;
         var sprite:TiphonSprite = this._aSprites[this._nSelectedChara];
         var base:Array = sprite.look.toString().split("|");
         if(list.length)
         {
            list.unshift(base[1].split(","));
            base[1] = list.join(",");
         }
         else
         {
            bones = base[1].split(",");
            k = 0;
            while(k < numDelete)
            {
               bones.pop();
               k++;
            }
            base[1] = bones.join(",");
         }
         var tel:TiphonEntityLook = TiphonEntityLook.fromString(base.join("|"));
         sprite.look.updateFrom(tel);
      }
      
      public function getMountainCtr(i:int) : Object {
         return this._aMountainsCtr[i];
      }
      
      private function charactersDisplay() : void {
         var g:GraphicContainer = null;
         var te:TiphonEntity = null;
         var children:uint = 0;
         var j:* = 0;
         var t:* = NaN;
         var i:* = 0;
         var angle:* = NaN;
         var coef:* = NaN;
         var ctr:GraphicContainer = null;
         var characterInfo:CBI = null;
         var oPerso:TiphonEntity = null;
         var cat:* = undefined;
         var mountain:Texture = null;
         var ie:InstanceEvent = null;
         var num:int = this._aSprites.length;
         var k:int = 0;
         while(k < num)
         {
            te = this._aSprites.shift();
            te.destroy();
            k++;
         }
         for each(g in this._aMountainsCtr)
         {
            g.remove();
         }
         if(this._aMountainsCtr.length > 0)
         {
            children = this._aMountainsCtr.numChildren;
            j = children - 1;
            while(j >= 0)
            {
               this._aMountainsCtr.removeChild(this._aMountainsCtr.getChildAt(j));
               j--;
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
            t = 2 * Math.PI / this._nNbCharacters;
            this._nRotation = 0;
            this._nRotationPieceTrg = 0;
            this._aRenderePartNames = new Array();
            i = 0;
            while(i < this._nNbCharacters)
            {
               if(this._aCharactersList[i])
               {
                  angle = t * i % (2 * Math.PI);
                  coef = Math.abs(angle - Math.PI) / Math.PI;
                  ctr = new GraphicContainer();
                  ctr.x = this._nWidthEllipsis * Math.cos(angle + Math.PI / 2) + this._nXCenterEllipsis;
                  ctr.y = this._nHeightEllipsis * Math.sin(angle + Math.PI / 2) + this._nYCenterEllipsis;
                  characterInfo = new CBI(this._aCharactersList[i].id,this._aCharactersList[i].breedId,new Array());
                  this._aEntitiesLook[i].look = SecureCenter.unsecure(this._aEntitiesLook[i].look);
                  oPerso = new TiphonEntity(this._aEntitiesLook[i].id,this._aEntitiesLook[i].look);
                  ctr.addChild(oPerso);
                  oPerso.name = "char" + i;
                  oPerso.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onMoutainPartRendered);
                  if(_animationModifier[oPerso.look.getBone()])
                  {
                     oPerso.addAnimationModifier(_animationModifier[oPerso.look.getBone()]);
                  }
                  if(_skinModifier[oPerso.look.getBone()])
                  {
                     oPerso.skinModifier = _skinModifier[oPerso.look.getBone()];
                  }
                  for(cat in _subEntitiesBehaviors)
                  {
                     if(_subEntitiesBehaviors[cat])
                     {
                        oPerso.setSubEntityBehaviour(cat,_subEntitiesBehaviors[cat]);
                     }
                  }
                  if(oPerso.look.getBone() == 1)
                  {
                     oPerso.setAnimationAndDirection("AnimStatique",2);
                  }
                  else
                  {
                     oPerso.setAnimationAndDirection("AnimStatique",3);
                  }
                  oPerso.x = -5;
                  oPerso.y = -64;
                  oPerso.scaleX = 2.2;
                  oPerso.scaleY = 2.2;
                  oPerso.cacheAsBitmap = true;
                  this._aSprites[i] = oPerso;
                  ctr.scaleX = ctr.scaleY = Math.max(0.3,coef);
                  ctr.alpha = Math.max(0.3,coef);
                  ctr.useHandCursor = true;
                  ctr.buttonMode = true;
                  if(this._nNbCharacters == 2)
                  {
                     if(i == 1)
                     {
                        ctr.x = this._nWidthEllipsis * Math.cos(angle + Math.PI / 6 + Math.PI / 2) + this._nXCenterEllipsis;
                        ctr.y = this._nHeightEllipsis * Math.sin(angle + Math.PI / 6 + Math.PI / 2) + this._nYCenterEllipsis;
                     }
                  }
                  if(this._nNbCharacters == 4)
                  {
                     if(i == 2)
                     {
                        ctr.x = this._nWidthEllipsis * Math.cos(angle + Math.PI / 6 + Math.PI / 2) + this._nXCenterEllipsis;
                        ctr.y = this._nHeightEllipsis * Math.sin(angle + Math.PI / 6 + Math.PI / 2) + this._nYCenterEllipsis;
                     }
                  }
                  mountain = new Texture();
                  ctr.addChildAt(mountain,0);
                  mountain.name = "char" + i;
                  mountain.dispatchMessages = true;
                  mountain.addEventListener(Event.COMPLETE,this.onMoutainPartRendered);
                  mountain.scale = 1.2;
                  mountain.y = -62;
                  mountain.uri = new Uri(this._sMountainUri + "assets.swf|base_" + characterInfo.breed);
                  mountain.finalize();
                  ie = new InstanceEvent(ctr,this._uiClass.uiClass);
                  ie.push(EventEnums.EVENT_ONRELEASE_MSG);
                  ie.push(EventEnums.EVENT_ONDOUBLECLICK_MSG);
                  UIEventManager.getInstance().registerInstance(ie);
                  if(i == 0)
                  {
                     this._charaSelCtr.addChild(this._midZCtr);
                  }
                  if(this._aEntitiesLook[i].disabled)
                  {
                     ctr.transform.colorTransform = new ColorTransform(0.6,0.6,0.6,1);
                  }
                  this._charaSelCtr.addChild(ctr);
                  this._ctrDepth.push(this._charaSelCtr.getChildIndex(ctr));
                  this._aMountainsCtr[i] = ctr;
               }
               i++;
            }
            this._charaSelCtr.addChild(this._frontZCtr);
         }
      }
      
      private function onMoutainPartRendered(event:Event) : void {
         if(event.type == TiphonEvent.RENDER_SUCCEED)
         {
            event.target.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onMoutainPartRendered);
         }
         else if(event.type == Event.COMPLETE)
         {
            event.target.removeEventListener(Event.COMPLETE,this.onMoutainPartRendered);
         }
         
         if((this._aRenderePartNames[event.target.name]) && (event.target.stage))
         {
            this.createMountainsCtrBitmap(this._aRenderePartNames[event.target.name],int(event.target.name.replace("char","")));
         }
         else
         {
            this._aRenderePartNames[event.target.name] = event.target.parent;
         }
      }
      
      private function createMountainsCtrBitmap(ctr:GraphicContainer, charWheelID:int) : void {
         var bmp:Bitmap = null;
         var previousAlpha:Number = ctr.alpha;
         ctr.alpha = 1;
         var previousScale:Number = ctr.scaleX;
         ctr.scaleX = ctr.scaleY = 1;
         if(ctr.numChildren > 2)
         {
            bmp = ctr.getChildAt(2) as Bitmap;
            if((bmp) && (bmp.bitmapData))
            {
               bmp.bitmapData.dispose();
            }
         }
         var bounds:Rectangle = ctr.getBounds(ctr);
         var bmpData:BitmapData = new BitmapData(bounds.width,bounds.height,true,5596808);
         bmpData.draw(ctr,new Matrix(1,0,0,1,-bounds.x,-bounds.y));
         if(!bmp)
         {
            bmp = new Bitmap(bmpData,"auto",true);
         }
         else
         {
            bmp.bitmapData = bmpData;
         }
         bmp.x = bounds.x;
         bmp.y = bounds.y;
         ctr.alpha = previousAlpha;
         ctr.scaleX = ctr.scaleY = previousScale;
         ctr.addChild(bmp);
         if(ctr.numChildren == 3)
         {
            ctr.getChildAt(0).visible = ctr.getChildAt(1).visible = charWheelID == this._nSelectedChara;
            ctr.getChildAt(2).visible = !(charWheelID == this._nSelectedChara);
         }
      }
      
      private function endRotationMountains() : void {
         EnterFrameDispatcher.removeEventListener(this.onRotateMountains);
         this._bMovingMountains = false;
      }
      
      private function rotateMountains(sens:int) : void {
         var listener:IInterfaceListener = null;
         var listener2:IInterfaceListener = null;
         this._nSelectedChara = this._nSelectedChara - sens;
         if(this._nSelectedChara >= this._aCharactersList.length)
         {
            this._nSelectedChara = this._nSelectedChara - this._aCharactersList.length;
         }
         if(this._nSelectedChara < 0)
         {
            this._nSelectedChara = this._aCharactersList.length + this._nSelectedChara;
         }
         var t:Number = 2 * Math.PI / this._nNbCharacters;
         this._sens = sens;
         this._nRotationStep = t;
         if(isNaN(this._nRotationPieceTrg))
         {
            this._nRotationPieceTrg = this._nRotation + this._nRotationStep * this._sens;
         }
         else
         {
            this._nRotationPieceTrg = this._nRotationPieceTrg + this._nRotationStep * this._sens;
         }
         if(sens == 1)
         {
            for each(listener in Berilia.getInstance().UISoundListeners)
            {
               listener.playUISound("16079");
            }
         }
         else
         {
            for each(listener2 in Berilia.getInstance().UISoundListeners)
            {
               listener2.playUISound("16080");
            }
         }
         EnterFrameDispatcher.addEventListener(this.onRotateMountains,"mountainsRotation",StageShareManager.stage.frameRate);
      }
      
      private function isIterable(obj:*) : Boolean {
         if(obj is Array)
         {
            return true;
         }
         if((!(obj["length"] == null)) && (!(obj["length"] == 0)) && (!isNaN(obj["length"])) && (!(obj[0] == null)) && (!(obj is String)))
         {
            return true;
         }
         return false;
      }
      
      override public function process(msg:Message) : Boolean {
         return false;
      }
      
      public function eventOnRelease(target:DisplayObject) : void {
      }
      
      public function eventOnDoubleClick(target:DisplayObject) : void {
         if(this._bMovingMountains)
         {
         }
      }
      
      public function eventOnRollOver(target:DisplayObject) : void {
      }
      
      public function eventOnRollOut(target:DisplayObject) : void {
      }
      
      public function eventOnShortcut(s:String) : Boolean {
         return false;
      }
      
      private function onRotateMountains(e:Event) : void {
         var ctr:GraphicContainer = null;
         var angle:* = NaN;
         var coef:* = NaN;
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
         var zOrder:Array = new Array();
         var i:int = 0;
         for each (ctr in this._aMountainsCtr)
         {
            angle = (this._nRotation + this._nRotationStep * i) % (2 * Math.PI);
            coef = Math.abs(Math.PI - (angle < 0?angle + 2 * Math.PI:angle) % (2 * Math.PI)) / Math.PI;
            zOrder.push(
               {
                  "ctr":ctr,
                  "z":coef
               });
            ctr.x = this._nWidthEllipsis * Math.cos(angle + Math.PI / 2) + this._nXCenterEllipsis;
            ctr.y = this._nHeightEllipsis * Math.sin(angle + Math.PI / 2) + this._nYCenterEllipsis;
            if(this._nNbCharacters == 2)
            {
               if(ctr.y < 300)
               {
                  ctr.x = this._nWidthEllipsis * Math.cos(angle + Math.PI / 6 + Math.PI / 2) + this._nXCenterEllipsis;
                  ctr.y = this._nHeightEllipsis * Math.sin(angle + Math.PI / 6 + Math.PI / 2) + this._nYCenterEllipsis;
               }
            }
            if(this._nNbCharacters == 4)
            {
               if(ctr.y < 300)
               {
                  ctr.x = this._nWidthEllipsis * Math.cos(angle + Math.PI / 6 + Math.PI / 2) + this._nXCenterEllipsis;
                  ctr.y = this._nHeightEllipsis * Math.sin(angle + Math.PI / 6 + Math.PI / 2) + this._nYCenterEllipsis;
               }
            }
            ctr.scaleX = ctr.scaleY = Math.max(0.3,coef);
            ctr.alpha = Math.max(0.3,coef);
            if(ctr.numChildren == 3)
            {
               ctr.getChildAt(0).visible = ctr.getChildAt(1).visible = i == this._nSelectedChara;
               ctr.getChildAt(2).visible = !(i == this._nSelectedChara);
            }
            i++;
         }
         zOrder.sortOn("z",Array.NUMERIC);
         i = 0;
         while(i < zOrder.length)
         {
            zOrder[i].ctr.parent.addChildAt(zOrder[i].ctr,this._ctrDepth[i]);
            i++;
         }
         if(this._charaSelCtr)
         {
            this._charaSelCtr.setChildIndex(this._frontZCtr,this._charaSelCtr.numChildren - 1);
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
   
   function TiphonEntity(id:uint, look:TiphonEntityLook) {
      super(look);
      this._id = id;
      mouseEnabled = false;
      mouseChildren = false;
   }
   
   private var _id:uint;
   
   public function get id() : int {
      return this._id;
   }
   
   public function set id(nValue:int) : void {
      this._id = nValue;
   }
   
   public function get position() : MapPoint {
      return null;
   }
   
   public function set position(oValue:MapPoint) : void {
   }
}
class CBI extends Object
{
   
   function CBI(id:uint, breed:int, colors:Array) {
      this.colors = new Array();
      super();
      this.id = id;
      this.breed = breed;
      this.colors = colors;
   }
   
   public var id:int;
   
   public var gfxId:int;
   
   public var breed:int;
   
   public var colors:Array;
}
