package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
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
      
      public function initGameFightSpectateMessage(effects:Vector.<FightDispellableEffectExtendedInformations> = null, marks:Vector.<GameActionMark> = null, gameTurn:uint = 0) : GameFightSpectateMessage {
         this.effects = effects;
         this.marks = marks;
         this.gameTurn = gameTurn;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.effects = new Vector.<FightDispellableEffectExtendedInformations>();
         this.marks = new Vector.<GameActionMark>();
         this.gameTurn = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightSpectateMessage(output);
      }
      
      public function serializeAs_GameFightSpectateMessage(output:IDataOutput) : void {
         output.writeShort(this.effects.length);
         var _i1:uint = 0;
         while(_i1 < this.effects.length)
         {
            (this.effects[_i1] as FightDispellableEffectExtendedInformations).serializeAs_FightDispellableEffectExtendedInformations(output);
            _i1++;
         }
         output.writeShort(this.marks.length);
         var _i2:uint = 0;
         while(_i2 < this.marks.length)
         {
            (this.marks[_i2] as GameActionMark).serializeAs_GameActionMark(output);
            _i2++;
         }
         if(this.gameTurn < 0)
         {
            throw new Error("Forbidden value (" + this.gameTurn + ") on element gameTurn.");
         }
         else
         {
            output.writeShort(this.gameTurn);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightSpectateMessage(input);
      }
      
      public function deserializeAs_GameFightSpectateMessage(input:IDataInput) : void {
         var _item1:FightDispellableEffectExtendedInformations = null;
         var _item2:GameActionMark = null;
         var _effectsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _effectsLen)
         {
            _item1 = new FightDispellableEffectExtendedInformations();
            _item1.deserialize(input);
            this.effects.push(_item1);
            _i1++;
         }
         var _marksLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _marksLen)
         {
            _item2 = new GameActionMark();
            _item2.deserialize(input);
            this.marks.push(_item2);
            _i2++;
         }
         this.gameTurn = input.readShort();
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
