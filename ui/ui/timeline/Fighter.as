package ui.timeline
{
   import d2components.ButtonContainer;
   import d2components.EntityDisplayer;
   import d2components.Texture;
   import d2components.Label;
   import d2hooks.*;
   import flash.utils.getTimer;
   import flash.filters.GlowFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class Fighter extends Object
   {
      
      public function Fighter(id:int, timelineUi:Object, num:uint) {
         super();
         this._id = id;
         var infos:Object = Api.fightApi.getFighterInformations(id);
         this._summoned = (!(infos.summoner == 0)) && (infos.summoned);
         this._timelineUi = timelineUi;
         this._frame = this.createFrame(this._summoned);
         this.displayFighter(id,num);
      }
      
      private static const SUMMONED_SCALE:Number = 0.8;
      
      private static var _framePool:Object;
      
      private static var _freeFrameId:uint = 0;
      
      private static function nextFrameName() : String {
         return "frame" + _freeFrameId++;
      }
      
      public static function cleanFramesPool() : void {
         _framePool = new Array();
      }
      
      private var _id:int;
      
      private var _alive:Boolean = true;
      
      private var _isCurrentPlayer:Boolean = false;
      
      private var _summoned:Boolean;
      
      private var _frame:ButtonContainer;
      
      private var _gfx:EntityDisplayer;
      
      private var _timeGauge:Texture;
      
      private var _pdvGauge:Texture;
      
      private var _shieldGauge:Texture;
      
      private var _lbl_number:Label;
      
      private var _lbl_waveNumber:Label;
      
      private var _frameTexture:Texture;
      
      private var _lifePoints:int;
      
      private var _shieldPoints:int;
      
      private var _highlighted:Boolean = false;
      
      private var _clockStart:int;
      
      private var _turnDuration:int;
      
      private var _timelineUi:Object;
      
      private var _selected:Boolean = false;
      
      public function get id() : int {
         return this._id;
      }
      
      public function get alive() : Boolean {
         return this._alive;
      }
      
      public function set alive(value:Boolean) : void {
         if(value != this._alive)
         {
            this.setAlive(value);
         }
      }
      
      public function get summoned() : Boolean {
         return this._summoned;
      }
      
      public function get frame() : ButtonContainer {
         return this._frame;
      }
      
      public function get timeGauge() : Texture {
         return this.frame.getChildByName("tx_timeGauge") as Texture;
      }
      
      public function get look() : Object {
         return this._gfx.look;
      }
      
      public function set look(object:Object) : void {
         this._gfx.look = object;
      }
      
      public function get selected() : Boolean {
         return this._selected;
      }
      
      public function set selected(value:Boolean) : void {
         if(this._selected != value)
         {
            if(value)
            {
               this._frameTexture.gotoAndStop = int(this._frameTexture.currentFrame) + 2;
            }
            else
            {
               this._frameTexture.gotoAndStop = int(this._frameTexture.currentFrame) - 2;
            }
         }
         this._selected = value;
      }
      
      public function destroy(force:Boolean = false) : void {
         if((this._summoned) || (force))
         {
            this._frame.visible = false;
            this._pdvGauge.dispatchMessages = false;
            this._shieldGauge.dispatchMessages = false;
            this._timeGauge.dispatchMessages = false;
            this._lifePoints = 0;
         }
         Api.sysApi.removeEventListener(this.onEnterFrame);
      }
      
      public function refreshPdv() : void {
         var infos:Object = Api.fightApi.getFighterInformations(this._id);
         if((infos) && (this._alive))
         {
            this.setPdv(infos.lifePoints);
         }
      }
      
      public function setPdv(lifePoints:int) : void {
         var infos:Object = Api.fightApi.getFighterInformations(this._id);
         if(lifePoints < 0)
         {
            lifePoints = 0;
         }
         this._lifePoints = lifePoints;
         var currentHeartPos:uint = int(lifePoints / infos.maxLifePoints * (this._pdvGauge.totalFrames - 1));
         if(currentHeartPos == 0)
         {
            currentHeartPos = 1;
         }
         this._pdvGauge.gotoAndStop = currentHeartPos.toString();
      }
      
      public function addPdv(added:int) : void {
         this.setPdv(this._lifePoints + added);
      }
      
      public function removePdv(removed:int) : void {
         this.setPdv(this._lifePoints - removed);
      }
      
      public function refreshShield() : void {
         var infos:Object = Api.fightApi.getFighterInformations(this._id);
         if(infos)
         {
            this.setShield(infos.shieldPoints);
         }
      }
      
      public function setShield(currentShield:int) : void {
         var currentHeartPos:uint = 0;
         var infos:Object = Api.fightApi.getFighterInformations(this._id);
         this._shieldPoints = currentShield;
         if(this._shieldPoints < 0)
         {
            this._shieldPoints = 0;
         }
         if(this._shieldPoints == 0)
         {
            this._shieldGauge.visible = false;
            if((this._frameTexture.currentFrame == 2) || (this._frameTexture.currentFrame == 4))
            {
               this._frameTexture.gotoAndStop = (int(this._frameTexture.currentFrame) - 1).toString();
            }
         }
         else
         {
            this._shieldGauge.visible = true;
            if((this._frameTexture.currentFrame == 1) || (this._frameTexture.currentFrame == 3))
            {
               this._frameTexture.gotoAndStop = (int(this._frameTexture.currentFrame) + 1).toString();
            }
            currentHeartPos = int(this._shieldPoints / infos.maxLifePoints * (this._shieldGauge.totalFrames - 1));
            this._shieldGauge.gotoAndStop = currentHeartPos.toString();
         }
      }
      
      public function startCountDown(turnDuration:int) : void {
         this._turnDuration = turnDuration;
         this._clockStart = getTimer();
         Api.sysApi.addEventListener(this.onEnterFrame,"Timeline");
         this._isCurrentPlayer = true;
         var glow:GlowFilter = new GlowFilter(uint(Api.sysApi.getConfigEntry("colors.timeline.border_current_fighter")),1,this._timelineUi.getConstant("current_frame_border_width"),this._timelineUi.getConstant("current_frame_border_width"),2,BitmapFilterQuality.HIGH);
         this._timeGauge.filters = [glow];
      }
      
      public function stopCountDown() : void {
         Api.sysApi.removeEventListener(this.onEnterFrame);
         this._isCurrentPlayer = false;
         this._timeGauge.filters = [];
         this.updateTime(0);
      }
      
      public function updateTime(value:int = 0) : void {
         var pos:uint = 0;
         if(this.alive)
         {
            pos = value / 100 * (this._timeGauge.totalFrames - 1);
         }
         else
         {
            pos = this._timeGauge.totalFrames;
         }
         this._timeGauge.gotoAndStop = pos;
      }
      
      public function updateSprite() : void {
         var infos:Object = Api.fightApi.getFighterInformations(this.id);
         this._gfx.look = infos.look;
      }
      
      public function set highlight(value:Boolean) : void {
         this._highlighted = value;
         if(value)
         {
            this._frame.y = 0;
         }
         else
         {
            this._frame.y = this._timelineUi.getConstant("frame_offset_vertical");
         }
      }
      
      public function get highlight() : Boolean {
         return this._highlighted;
      }
      
      public function updateNumber(num:uint) : void {
         if((Api.configApi.getConfigProperty("dofus","orderFighters")) && (this._alive))
         {
            this._lbl_number.text = num.toString();
         }
         else
         {
            this._lbl_number.text = "";
         }
      }
      
      public function get isCurrentPlayer() : Boolean {
         return this._isCurrentPlayer;
      }
      
      private function displayFighter(id:int, num:uint) : void {
         var mask_height:* = 0;
         var mask_x:* = 0;
         var mask_y:* = 0;
         var mask_width:* = 0;
         var mask_corner:* = 0;
         var glow2:GlowFilter = null;
         var bmp_scale:Number = 1;
         mask_height = this._timelineUi.getConstant("mask_height");
         mask_x = this._timelineUi.getConstant("mask_x");
         mask_y = this._timelineUi.getConstant("mask_y");
         mask_width = this._timelineUi.getConstant("mask_width");
         mask_corner = this._timelineUi.getConstant("mask_corner");
         if(this._summoned)
         {
            mask_height = mask_height * SUMMONED_SCALE;
            mask_x = mask_x * SUMMONED_SCALE;
            mask_y = mask_y * SUMMONED_SCALE;
            mask_width = mask_width * SUMMONED_SCALE;
            mask_corner = mask_corner * SUMMONED_SCALE;
            bmp_scale = bmp_scale * SUMMONED_SCALE;
         }
         var infos:Object = Api.fightApi.getFighterInformations(id);
         this._gfx = Api.uiApi.createComponent("EntityDisplayer") as EntityDisplayer;
         this._gfx.width = mask_width;
         this._gfx.height = mask_height;
         this._gfx.look = infos.look;
         this._gfx.setAnimationAndDirection("AnimArtwork",1);
         this._gfx.view = "timeline";
         var glow:GlowFilter = new GlowFilter(16777215,0.3,20,20,2,BitmapFilterQuality.HIGH);
         this._gfx.filters = [glow];
         this._frame.addChild(this._gfx);
         var charMask:Sprite = new Sprite();
         charMask.graphics.beginFill(16733440);
         charMask.graphics.drawRoundRect(mask_x,mask_y,mask_width,mask_height,mask_corner,mask_corner);
         charMask.graphics.endFill();
         this._frame.addChild(charMask);
         this._gfx.mask = charMask;
         if(infos.team == "challenger")
         {
            this._pdvGauge.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_pdv_challenger"));
            if(!this._pdvGauge.finalized)
            {
               this._pdvGauge.finalize();
            }
         }
         else
         {
            this._pdvGauge.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_pdv_defender"));
            if(!this._pdvGauge.finalized)
            {
               this._pdvGauge.finalize();
            }
         }
         this._lbl_number = Api.uiApi.createComponent("Label") as Label;
         this._lbl_number.width = 30;
         this._lbl_number.height = 20;
         this._lbl_number.x = 0;
         this._lbl_number.y = mask_height - 15;
         this._lbl_number.css = Api.uiApi.createUri(this._timelineUi.getConstant("css") + "normal.css");
         if((Api.configApi.getConfigProperty("dofus","orderFighters")) && (infos.isAlive))
         {
            this._lbl_number.text = num.toString();
         }
         else
         {
            this._lbl_number.text = "";
         }
         glow2 = new GlowFilter(Api.sysApi.getConfigEntry("colors.text.glow"),1,3,3,4,3);
         this._lbl_number.filters = [glow2];
         this._frame.addChild(this._lbl_number);
         this._lbl_waveNumber = Api.uiApi.createComponent("Label") as Label;
         this._lbl_waveNumber.width = 30;
         this._lbl_waveNumber.height = 20;
         this._lbl_waveNumber.x = 0;
         this._lbl_waveNumber.y = 0;
         this._lbl_waveNumber.css = Api.uiApi.createUri(this._timelineUi.getConstant("css") + "normal.css");
         if(infos.wave > 0)
         {
            this._lbl_waveNumber.text = infos.wave;
         }
         else
         {
            this._lbl_waveNumber.text = "";
         }
         glow2 = new GlowFilter(Api.sysApi.getConfigEntry("colors.text.glow"),1,3,3,4,3);
         this._lbl_waveNumber.filters = [glow2];
         this._frame.addChild(this._lbl_waveNumber);
         this.setPdv(infos.lifePoints);
         this.updateTime(0);
      }
      
      private function createFrame(summoned:Boolean) : ButtonContainer {
         var frame:ButtonContainer = null;
         var stateChangingProperties:Array = null;
         var state:* = 0;
         if((summoned) && (_framePool.length > 0))
         {
            this._pdvGauge = frame.getChildByName("tx_pdvGauge") as Texture;
            this._shieldGauge = frame.getChildByName("tx_shieldGauge") as Texture;
            this._timeGauge = frame.getChildByName("tx_timeGauge") as Texture;
            frame = _framePool.pop();
            frame.visible = true;
            this._timeGauge.dispatchMessages = true;
            this._pdvGauge.dispatchMessages = true;
            this._shieldGauge.dispatchMessages = true;
         }
         else
         {
            frame = Api.uiApi.createContainer("ButtonContainer") as ButtonContainer;
            if(summoned)
            {
               frame.width = this._timelineUi.getConstant("frame_summon_width");
               frame.height = this._timelineUi.getConstant("frame_summon_height");
            }
            else
            {
               frame.width = this._timelineUi.getConstant("frame_char_width");
               frame.height = this._timelineUi.getConstant("frame_char_height");
            }
            frame.name = nextFrameName();
            frame.y = this._timelineUi.getConstant("frame_offset_vertical");
            this._timeGauge = Api.uiApi.createComponent("Texture") as Texture;
            this._timeGauge.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_time"));
            this._timeGauge.width = frame.width;
            this._timeGauge.height = frame.height;
            this._timeGauge.name = "tx_timeGauge";
            this._timeGauge.dispatchMessages = true;
            this._timeGauge.finalize();
            this._frameTexture = Api.uiApi.createComponent("Texture") as Texture;
            this._frameTexture.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_frame"));
            this._frameTexture.name = "tx_frame";
            this._frameTexture.width = frame.width;
            this._frameTexture.height = frame.height;
            this._frameTexture.finalize();
            this._pdvGauge = Api.uiApi.createComponent("Texture") as Texture;
            this._pdvGauge.width = this._timelineUi.getConstant("pdv_width");
            this._pdvGauge.height = this._timelineUi.getConstant("pdv_height");
            this._pdvGauge.name = "tx_pdvGauge";
            this._pdvGauge.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_pdv_defender"));
            if(summoned)
            {
               this._pdvGauge.x = this._timelineUi.getConstant("pdv_summon_x");
               this._pdvGauge.y = this._timelineUi.getConstant("pdv_summon_y");
               this._pdvGauge.scale = SUMMONED_SCALE;
            }
            else
            {
               this._pdvGauge.x = this._timelineUi.getConstant("pdv_x");
               this._pdvGauge.y = this._timelineUi.getConstant("pdv_y");
            }
            this._pdvGauge.dispatchMessages = true;
            this._pdvGauge.finalize();
            this._shieldGauge = Api.uiApi.createComponent("Texture") as Texture;
            this._shieldGauge.width = this._timelineUi.getConstant("pdv_width");
            this._shieldGauge.height = this._timelineUi.getConstant("pdv_height");
            this._shieldGauge.name = "tx_shieldGauge";
            this._shieldGauge.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_shieldPoints"));
            if(summoned)
            {
               this._shieldGauge.x = this._timelineUi.getConstant("shield_summon_x");
               this._shieldGauge.y = this._timelineUi.getConstant("shield_summon_y");
               this._shieldGauge.scale = SUMMONED_SCALE;
            }
            else
            {
               this._shieldGauge.x = this._timelineUi.getConstant("shield_x");
               this._shieldGauge.y = this._timelineUi.getConstant("shield_y");
            }
            this._shieldGauge.visible = false;
            this._shieldGauge.dispatchMessages = true;
            this._shieldGauge.finalize();
            frame.addChild(this._timeGauge);
            frame.addChild(this._frameTexture);
            frame.addChild(this._shieldGauge);
            frame.addChild(this._pdvGauge);
            stateChangingProperties = new Array();
            state = Api.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_OVER;
            stateChangingProperties[state] = new Array();
            stateChangingProperties[state][this._timeGauge.name] = new Array();
            stateChangingProperties[state][this._timeGauge.name]["luminosity"] = 1.5;
            stateChangingProperties[state][this._pdvGauge.name] = new Array();
            stateChangingProperties[state][this._pdvGauge.name]["luminosity"] = 1.5;
            stateChangingProperties[state][this._shieldGauge.name] = new Array();
            stateChangingProperties[state][this._shieldGauge.name]["luminosity"] = 1.5;
            frame.changingStateData = stateChangingProperties;
         }
         return frame;
      }
      
      private function setAlive(alive:Boolean) : void {
         var infos:Object = null;
         this._alive = alive;
         if(this._alive)
         {
            infos = Api.fightApi.getFighterInformations(this._id);
            this.setPdv(infos.lifePoints);
            this._gfx.transform.colorTransform = new ColorTransform();
         }
         else
         {
            this.setPdv(0);
            this.setShield(0);
            this._gfx.transform.colorTransform = new ColorTransform(0.6,0.6,0.6,0.7);
         }
         this.updateTime(0);
      }
      
      private function onEnterFrame() : void {
         var clock:uint = getTimer();
         var percentTime:Number = (clock - this._clockStart) / this._turnDuration * 100;
         if(this._isCurrentPlayer)
         {
            this.updateTime(percentTime);
         }
      }
   }
}
