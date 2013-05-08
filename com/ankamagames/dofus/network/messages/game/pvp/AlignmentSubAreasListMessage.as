package com.ankamagames.dofus.network.messages.game.pvp
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class AlignmentSubAreasListMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function AlignmentSubAreasListMessage() {
         this.angelsSubAreas=new Vector.<int>();
         this.evilsSubAreas=new Vector.<int>();
         super();
      }

      public static const protocolId:uint = 6059;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var angelsSubAreas:Vector.<int>;

      public var evilsSubAreas:Vector.<int>;

      override public function getMessageId() : uint {
         return 6059;
      }

      public function initAlignmentSubAreasListMessage(angelsSubAreas:Vector.<int>=null, evilsSubAreas:Vector.<int>=null) : AlignmentSubAreasListMessage {
         this.angelsSubAreas=angelsSubAreas;
         this.evilsSubAreas=evilsSubAreas;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.angelsSubAreas=new Vector.<int>();
         this.evilsSubAreas=new Vector.<int>();
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
         this.serializeAs_AlignmentSubAreasListMessage(output);
      }

      public function serializeAs_AlignmentSubAreasListMessage(output:IDataOutput) : void {
         output.writeShort(this.angelsSubAreas.length);
         var _i1:uint = 0;
         while(_i1<this.angelsSubAreas.length)
         {
            output.writeShort(this.angelsSubAreas[_i1]);
            _i1++;
         }
         output.writeShort(this.evilsSubAreas.length);
         var _i2:uint = 0;
         while(_i2<this.evilsSubAreas.length)
         {
            output.writeShort(this.evilsSubAreas[_i2]);
            _i2++;
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AlignmentSubAreasListMessage(input);
      }

      public function deserializeAs_AlignmentSubAreasListMessage(input:IDataInput) : void {
         var _val1:* = 0;
         var _val2:* = 0;
         var _angelsSubAreasLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1<_angelsSubAreasLen)
         {
            _val1=input.readShort();
            this.angelsSubAreas.push(_val1);
            _i1++;
         }
         var _evilsSubAreasLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2<_evilsSubAreasLen)
         {
            _val2=input.readShort();
            this.evilsSubAreas.push(_val2);
            _i2++;
         }
      }
   }

}