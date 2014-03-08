package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
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
         return this._isInitialized;
      }
      
      public var alliances:Vector.<AllianceVersatileInformations>;
      
      override public function getMessageId() : uint {
         return 6436;
      }
      
      public function initAllianceVersatileInfoListMessage(param1:Vector.<AllianceVersatileInformations>=null) : AllianceVersatileInfoListMessage {
         this.alliances = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.alliances = new Vector.<AllianceVersatileInformations>();
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
         this.serializeAs_AllianceVersatileInfoListMessage(param1);
      }
      
      public function serializeAs_AllianceVersatileInfoListMessage(param1:IDataOutput) : void {
         param1.writeShort(this.alliances.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.alliances.length)
         {
            (this.alliances[_loc2_] as AllianceVersatileInformations).serializeAs_AllianceVersatileInformations(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AllianceVersatileInfoListMessage(param1);
      }
      
      public function deserializeAs_AllianceVersatileInfoListMessage(param1:IDataInput) : void {
         var _loc4_:AllianceVersatileInformations = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new AllianceVersatileInformations();
            _loc4_.deserialize(param1);
            this.alliances.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
