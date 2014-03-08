package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightSpectateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightSpectateMessage() {
         this.effects = new Vector.<FightDispellableEffectExtendedInformations>();
         this.marks = new Vector.<GameActionMark>();
         super();
      }
      
      public static const protocolId:uint = 6069;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var effects:Vector.<FightDispellableEffectExtendedInformations>;
      
      public var marks:Vector.<GameActionMark>;
      
      public var gameTurn:uint = 0;
      
      override public function getMessageId() : uint {
         return 6069;
      }
      
      public function initGameFightSpectateMessage(param1:Vector.<FightDispellableEffectExtendedInformations>=null, param2:Vector.<GameActionMark>=null, param3:uint=0) : GameFightSpectateMessage {
         this.effects = param1;
         this.marks = param2;
         this.gameTurn = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.effects = new Vector.<FightDispellableEffectExtendedInformations>();
         this.marks = new Vector.<GameActionMark>();
         this.gameTurn = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightSpectateMessage(param1);
      }
      
      public function serializeAs_GameFightSpectateMessage(param1:IDataOutput) : void {
         param1.writeShort(this.effects.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.effects.length)
         {
            (this.effects[_loc2_] as FightDispellableEffectExtendedInformations).serializeAs_FightDispellableEffectExtendedInformations(param1);
            _loc2_++;
         }
         param1.writeShort(this.marks.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.marks.length)
         {
            (this.marks[_loc3_] as GameActionMark).serializeAs_GameActionMark(param1);
            _loc3_++;
         }
         if(this.gameTurn < 0)
         {
            throw new Error("Forbidden value (" + this.gameTurn + ") on element gameTurn.");
         }
         else
         {
            param1.writeShort(this.gameTurn);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightSpectateMessage(param1);
      }
      
      public function deserializeAs_GameFightSpectateMessage(param1:IDataInput) : void {
         var _loc6_:FightDispellableEffectExtendedInformations = null;
         var _loc7_:GameActionMark = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = new FightDispellableEffectExtendedInformations();
            _loc6_.deserialize(param1);
            this.effects.push(_loc6_);
            _loc3_++;
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new GameActionMark();
            _loc7_.deserialize(param1);
            this.marks.push(_loc7_);
            _loc5_++;
         }
         this.gameTurn = param1.readShort();
         if(this.gameTurn < 0)
         {
            throw new Error("Forbidden value (" + this.gameTurn + ") on element of GameFightSpectateMessage.gameTurn.");
         }
         else
         {
            return;
         }
      }
   }
}
