package com.ankamagames.dofus.internalDatacenter.fight
{
   import flash.utils.Proxy;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.challenges.Challenge;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.utils.flash_proxy;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   
   use namespace flash_proxy;
   
   public class ChallengeWrapper extends Proxy implements IDataCenter
   {
      
      public function ChallengeWrapper() {
         super();
      }
      
      public static function create() : ChallengeWrapper {
         return new ChallengeWrapper();
      }
      
      private var _challenge:Challenge;
      
      private var _id:uint;
      
      private var _targetId:int;
      
      private var _targetName:String;
      
      private var _targetLevel:int;
      
      private var _xpBonus:uint;
      
      private var _dropBonus:uint;
      
      private var _result:uint;
      
      private var _uri:Uri;
      
      public function set id(id:uint) : void {
         this._challenge = Challenge.getChallengeById(id);
         this._id = id;
      }
      
      public function set targetId(targetId:int) : void {
         this._targetId = targetId;
         this._targetName = this.getFightFrame().getFighterName(targetId);
         this._targetLevel = this.getFightFrame().getFighterLevel(targetId);
      }
      
      public function set xpBonus(xpBonus:uint) : void {
         this._xpBonus = xpBonus;
      }
      
      public function set dropBonus(dropBonus:uint) : void {
         this._dropBonus = dropBonus;
      }
      
      public function set result(result:uint) : void {
         this._result = result;
      }
      
      public function get id() : uint {
         return this._id;
      }
      
      public function get targetId() : int {
         return this._targetId;
      }
      
      public function get targetName() : String {
         return this._targetName;
      }
      
      public function get targetLevel() : int {
         return this._targetLevel;
      }
      
      public function get xpBonus() : uint {
         return this._xpBonus;
      }
      
      public function get dropBonus() : uint {
         return this._dropBonus;
      }
      
      public function get result() : uint {
         return this._result;
      }
      
      public function get iconUri() : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.challenges").concat(this.id).concat(".png"));
         }
         return this._uri;
      }
      
      public function get description() : String {
         return this._challenge.description;
      }
      
      public function get name() : String {
         return this._challenge.name;
      }
      
      override flash_proxy function getProperty(name:*) : * {
         var l:* = undefined;
         var r:* = undefined;
         if(isAttribute(name))
         {
            return this[name];
         }
         l = Challenge.getChallengeById(this.id);
         if(!l)
         {
            r = "";
         }
         try
         {
            return l[name];
         }
         catch(e:Error)
         {
            return "Error_on_challenge_" + name;
         }
      }
      
      private function getFightFrame() : FightContextFrame {
         return Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
      }
   }
}
