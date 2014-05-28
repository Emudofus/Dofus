package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.social.AllianceVersatileInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceVersatileInfoListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceVersatileInfoListMessage() {
         this.alliances = new Vector.<AllianceVersatileInformations>();
         super();
      }
      
      public static const protocolId:uint = 6436;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: NullPointerException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public var alliances:Vector.<AllianceVersatileInformations>;
      
      override public function getMessageId() : uint {
         return 6436;
      }
      
      public function initAllianceVersatileInfoListMessage(alliances:Vector.<AllianceVersatileInformations> = null) : AllianceVersatileInfoListMessage {
         this.alliances = alliances;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.alliances = new Vector.<AllianceVersatileInformations>();
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
         this.serializeAs_AllianceVersatileInfoListMessage(output);
      }
      
      public function serializeAs_AllianceVersatileInfoListMessage(output:IDataOutput) : void {
         output.writeShort(this.alliances.length);
         var _i1:uint = 0;
         while(_i1 < this.alliances.length)
         {
            (this.alliances[_i1] as AllianceVersatileInformations).serializeAs_AllianceVersatileInformations(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceVersatileInfoListMessage(input);
      }
      
      public function deserializeAs_AllianceVersatileInfoListMessage(input:IDataInput) : void {
         var _item1:AllianceVersatileInformations = null;
         var _alliancesLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _alliancesLen)
         {
            _item1 = new AllianceVersatileInformations();
            _item1.deserialize(input);
            this.alliances.push(_item1);
            _i1++;
         }
      }
   }
}
