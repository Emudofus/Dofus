package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameFightSynchronizeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightSynchronizeMessage() {
         this.fighters = new Vector.<GameFightFighterInformations>();
         super();
      }
      
      public static const protocolId:uint = 5921;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fighters:Vector.<GameFightFighterInformations>;
      
      override public function getMessageId() : uint {
         return 5921;
      }
      
      public function initGameFightSynchronizeMessage(fighters:Vector.<GameFightFighterInformations>=null) : GameFightSynchronizeMessage {
         this.fighters = fighters;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fighters = new Vector.<GameFightFighterInformations>();
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
         this.serializeAs_GameFightSynchronizeMessage(output);
      }
      
      public function serializeAs_GameFightSynchronizeMessage(output:IDataOutput) : void {
         output.writeShort(this.fighters.length);
         var _i1:uint = 0;
         while(_i1 < this.fighters.length)
         {
            output.writeShort((this.fighters[_i1] as GameFightFighterInformations).getTypeId());
            (this.fighters[_i1] as GameFightFighterInformations).serialize(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightSynchronizeMessage(input);
      }
      
      public function deserializeAs_GameFightSynchronizeMessage(input:IDataInput) : void {
         var _id1:uint = 0;
         var _item1:GameFightFighterInformations = null;
         var _fightersLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _fightersLen)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(GameFightFighterInformations,_id1);
            _item1.deserialize(input);
            this.fighters.push(_item1);
            _i1++;
         }
      }
   }
}
