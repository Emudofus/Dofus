package com.ankamagames.dofus.network.messages.web.krosmaster
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.web.krosmaster.KrosmasterFigure;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class KrosmasterInventoryMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function KrosmasterInventoryMessage() {
         this.figures = new Vector.<KrosmasterFigure>();
         super();
      }
      
      public static const protocolId:uint = 6350;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var figures:Vector.<KrosmasterFigure>;
      
      override public function getMessageId() : uint {
         return 6350;
      }
      
      public function initKrosmasterInventoryMessage(figures:Vector.<KrosmasterFigure> = null) : KrosmasterInventoryMessage {
         this.figures = figures;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.figures = new Vector.<KrosmasterFigure>();
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
         this.serializeAs_KrosmasterInventoryMessage(output);
      }
      
      public function serializeAs_KrosmasterInventoryMessage(output:IDataOutput) : void {
         output.writeShort(this.figures.length);
         var _i1:uint = 0;
         while(_i1 < this.figures.length)
         {
            (this.figures[_i1] as KrosmasterFigure).serializeAs_KrosmasterFigure(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_KrosmasterInventoryMessage(input);
      }
      
      public function deserializeAs_KrosmasterInventoryMessage(input:IDataInput) : void {
         var _item1:KrosmasterFigure = null;
         var _figuresLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _figuresLen)
         {
            _item1 = new KrosmasterFigure();
            _item1.deserialize(input);
            this.figures.push(_item1);
            _i1++;
         }
      }
   }
}
