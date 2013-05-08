package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookAndGradeInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class PrismFightDefendersStateMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function PrismFightDefendersStateMessage() {
         this.mainFighters=new Vector.<CharacterMinimalPlusLookAndGradeInformations>();
         this.reserveFighters=new Vector.<CharacterMinimalPlusLookAndGradeInformations>();
         super();
      }

      public static const protocolId:uint = 5899;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var fightId:Number = 0;

      public var mainFighters:Vector.<CharacterMinimalPlusLookAndGradeInformations>;

      public var reserveFighters:Vector.<CharacterMinimalPlusLookAndGradeInformations>;

      override public function getMessageId() : uint {
         return 5899;
      }

      public function initPrismFightDefendersStateMessage(fightId:Number=0, mainFighters:Vector.<CharacterMinimalPlusLookAndGradeInformations>=null, reserveFighters:Vector.<CharacterMinimalPlusLookAndGradeInformations>=null) : PrismFightDefendersStateMessage {
         this.fightId=fightId;
         this.mainFighters=mainFighters;
         this.reserveFighters=reserveFighters;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.fightId=0;
         this.mainFighters=new Vector.<CharacterMinimalPlusLookAndGradeInformations>();
         this.reserveFighters=new Vector.<CharacterMinimalPlusLookAndGradeInformations>();
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
         this.serializeAs_PrismFightDefendersStateMessage(output);
      }

      public function serializeAs_PrismFightDefendersStateMessage(output:IDataOutput) : void {
         output.writeDouble(this.fightId);
         output.writeShort(this.mainFighters.length);
         var _i2:uint = 0;
         while(_i2<this.mainFighters.length)
         {
            (this.mainFighters[_i2] as CharacterMinimalPlusLookAndGradeInformations).serializeAs_CharacterMinimalPlusLookAndGradeInformations(output);
            _i2++;
         }
         output.writeShort(this.reserveFighters.length);
         var _i3:uint = 0;
         while(_i3<this.reserveFighters.length)
         {
            (this.reserveFighters[_i3] as CharacterMinimalPlusLookAndGradeInformations).serializeAs_CharacterMinimalPlusLookAndGradeInformations(output);
            _i3++;
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismFightDefendersStateMessage(input);
      }

      public function deserializeAs_PrismFightDefendersStateMessage(input:IDataInput) : void {
         var _item2:CharacterMinimalPlusLookAndGradeInformations = null;
         var _item3:CharacterMinimalPlusLookAndGradeInformations = null;
         this.fightId=input.readDouble();
         var _mainFightersLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2<_mainFightersLen)
         {
            _item2=new CharacterMinimalPlusLookAndGradeInformations();
            _item2.deserialize(input);
            this.mainFighters.push(_item2);
            _i2++;
         }
         var _reserveFightersLen:uint = input.readUnsignedShort();
         var _i3:uint = 0;
         while(_i3<_reserveFightersLen)
         {
            _item3=new CharacterMinimalPlusLookAndGradeInformations();
            _item3.deserialize(input);
            this.reserveFighters.push(_item3);
            _i3++;
         }
      }
   }

}