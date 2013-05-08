package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookAndGradeInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class PrismFightDefenderAddMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function PrismFightDefenderAddMessage() {
         this.fighterMovementInformations=new CharacterMinimalPlusLookAndGradeInformations();
         super();
      }

      public static const protocolId:uint = 5895;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var fightId:Number = 0;

      public var fighterMovementInformations:CharacterMinimalPlusLookAndGradeInformations;

      public var inMain:Boolean = false;

      override public function getMessageId() : uint {
         return 5895;
      }

      public function initPrismFightDefenderAddMessage(fightId:Number=0, fighterMovementInformations:CharacterMinimalPlusLookAndGradeInformations=null, inMain:Boolean=false) : PrismFightDefenderAddMessage {
         this.fightId=fightId;
         this.fighterMovementInformations=fighterMovementInformations;
         this.inMain=inMain;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.fightId=0;
         this.fighterMovementInformations=new CharacterMinimalPlusLookAndGradeInformations();
         this._isInitialized=false;
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
         this.serializeAs_PrismFightDefenderAddMessage(output);
      }

      public function serializeAs_PrismFightDefenderAddMessage(output:IDataOutput) : void {
         output.writeDouble(this.fightId);
         this.fighterMovementInformations.serializeAs_CharacterMinimalPlusLookAndGradeInformations(output);
         output.writeBoolean(this.inMain);
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismFightDefenderAddMessage(input);
      }

      public function deserializeAs_PrismFightDefenderAddMessage(input:IDataInput) : void {
         this.fightId=input.readDouble();
         this.fighterMovementInformations=new CharacterMinimalPlusLookAndGradeInformations();
         this.fighterMovementInformations.deserialize(input);
         this.inMain=input.readBoolean();
      }
   }

}