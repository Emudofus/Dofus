package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.PlayedCharacterApi;
   import d2api.SoundApi;
   import d2api.DataApi;
   import d2api.StorageApi;
   import d2api.ContextMenuApi;
   import d2api.UtilApi;
   import d2api.TooltipApi;
   import d2api.TimeApi;
   import d2api.AveragePricesApi;
   import flash.utils.Timer;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2components.Input;
   import d2components.Texture;
   import d2components.Grid;
   import d2components.EntityDisplayer;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2hooks.*;
   import d2actions.*;
   import d2enums.ComponentHookList;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import d2enums.SelectMethodEnum;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.tooltip.LocationEnum;
   import d2utils.ItemTooltipSettings;
   import d2enums.ChatActivableChannelsEnum;
   import d2enums.ShortcutHookListEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   
   public class ExchangeUi extends Object
   {
      
      public function ExchangeUi() {
         this._myTopTimer = new Timer(150,8);
         this._myBottomTimer = new Timer(150,8);
         super();
      }
      
      public static const EXCHANGE_COLOR_OK:String = "EXCHANGE_COLOR_OK";
      
      public static const EXCHANGE_COLOR_CHANGE:String = "EXCHANGE_COLOR_CHANGE";
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var modCommon:Object;
      
      public var soundApi:SoundApi;
      
      public var dataApi:DataApi;
      
      public var storageApi:StorageApi;
      
      public var menuApi:ContextMenuApi;
      
      public var utilApi:UtilApi;
      
      public var tooltipApi:TooltipApi;
      
      public var timeApi:TimeApi;
      
      public var averagePricesApi:AveragePricesApi;
      
      public var modContextMenu:Object;
      
      private var _playerName:String;
      
      private var _otherPlayerName:String;
      
      private var _otherPlayerId:int;
      
      private var _sourceName:String;
      
      private var _targetName:String;
      
      private var _currentPlayerKama:uint;
      
      private var _leftItems:Array;
      
      private var _rightItems:Array;
      
      private var _leftCurrentPods:int;
      
      private var _rightCurrentPods:int;
      
      private var _leftMaxPods:int;
      
      private var _rightMaxPods:int;
      
      private var _leftExchangePods:int = 0;
      
      private var _rightExchangePods:int = 0;
      
      private var _rightPlayerKamaExchange:int;
      
      protected var _leftPlayerKamaExchange:int;
      
      private var _playerIsReady:Boolean = false;
      
      private var _itemUIDAskedToMove:int;
      
      private var _itemQuantityAskedToMove:int;
      
      private var _timeDelay:Number = 2000;
      
      private var _timerDelay:Timer;
      
      private var _timeKamaDelay:Number = 1000;
      
      private var _timerKamaDelay:Timer;
      
      private var _timerPosButtons:Timer;
      
      private var _posXValid:int;
      
      private var _posYValid:int;
      
      private var _posXCancel:int;
      
      private var _posYCancel:int;
      
      private var _waitingObject:Object;
      
      private var _hasExchangeResult:Boolean = false;
      
      private var _success:Boolean = false;
      
      private var _myTopTimer:Timer;
      
      private var _myBottomTimer:Timer;
      
      private var _redTop:Boolean;
      
      private var _redBottom:Boolean;
      
      private var _lbl_estimated_value_left_default_x:Number;
      
      private var _lbl_estimated_value_right_default_x:Number;
      
      private var estimated_value_left:Number;
      
      private var estimated_value_right:Number;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_itemBlock:GraphicContainer;
      
      public var ctr_item:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_validate:ButtonContainer;
      
      public var btn_cancel:ButtonContainer;
      
      public var lbl_leftPlayerName:Label;
      
      public var lbl_rightPlayerName:Label;
      
      public var input_kamaLeft:Label;
      
      public var input_kamaRight:Input;
      
      public var lbl_estimated_left:Label;
      
      public var lbl_estimated_value_left:Label;
      
      public var lbl_estimated_right:Label;
      
      public var lbl_estimated_value_right:Label;
      
      public var tx_gridRightTop:Texture;
      
      public var tx_gridLeftTop:Texture;
      
      public var tx_gridRightBottom:Texture;
      
      public var tx_gridLeftBottom:Texture;
      
      public var tx_bgLeftBottom:Texture;
      
      public var tx_bgLeftTop:Texture;
      
      public var tx_podsBar_right:Texture;
      
      public var tx_podsBar_left:Texture;
      
      public var tx_estimated_value_warning_left:Texture;
      
      public var tx_estimated_value_warning_right:Texture;
      
      public var gd_left:Grid;
      
      public var gd_right:Grid;
      
      public var playerLeftLook:EntityDisplayer;
      
      public var playerRightLook:EntityDisplayer;
      
      public function main(oParam:Object = null) : void {
         this.sysApi.disableWorldInteraction(false);
         this.btn_cancel.soundId = SoundEnum.CANCEL_BUTTON;
         this.btn_validate.soundId = SoundEnum.OK_BUTTON;
         this.sysApi.addHook(ExchangeObjectModified,this.onExchangeObjectModified);
         this.sysApi.addHook(ExchangeObjectAdded,this.onExchangeObjectAdded);
         this.sysApi.addHook(ExchangeObjectRemoved,this.onExchangeObjectRemoved);
         this.sysApi.addHook(ExchangeKamaModified,this.onExchangeKamaModified);
         this.sysApi.addHook(AskExchangeMoveObject,this.onAskExchangeMoveObject);
         this.sysApi.addHook(ExchangeIsReady,this.onExchangeIsReady);
         this.sysApi.addHook(DoubleClickItemInventory,this.onDoubleClickItemInventory);
         this.sysApi.addHook(ObjectSelected,this.onObjectSelected);
         this.sysApi.addHook(ExchangeLeave,this.onExchangeLeave);
         this.uiApi.addComponentHook(this.playerLeftLook,"onRelease");
         this.uiApi.addComponentHook(this.playerLeftLook,"onRightClick");
         this.uiApi.addComponentHook(this.playerRightLook,"onRelease");
         this.uiApi.addComponentHook(this.playerRightLook,"onRightClick");
         this.lbl_estimated_left.text = this.lbl_estimated_right.text = this.uiApi.getText("ui.exchange.estimatedValue") + " :";
         this._lbl_estimated_value_left_default_x = this.lbl_estimated_value_left.x;
         this._lbl_estimated_value_right_default_x = this.lbl_estimated_value_right.x;
         this.playerLeftLook.mouseEnabled = true;
         this.playerLeftLook.handCursor = true;
         this.playerRightLook.mouseEnabled = true;
         this.playerRightLook.handCursor = true;
         this.ctr_itemBlock.visible = false;
         this._leftItems = new Array();
         this._rightItems = new Array();
         this._playerName = this.playerApi.getPlayedCharacterInfo().name;
         this._sourceName = oParam.sourceName;
         this._targetName = oParam.targetName;
         this._currentPlayerKama = this.playerApi.characteristics().kamas;
         this.input_kamaRight.maxChars = 13;
         this.input_kamaRight.restrictChars = "0-9  ";
         this.input_kamaRight.numberMax = 2000000000;
         this.uiApi.addComponentHook(this.input_kamaRight,ComponentHookList.ON_CHANGE);
         this.checkAcceptButton();
         this._otherPlayerId = oParam.otherId;
         if(this._sourceName == this._playerName)
         {
            this._otherPlayerName = this._targetName;
            this.playerRightLook.look = oParam.sourceLook;
            this.playerLeftLook.look = oParam.targetLook;
            this._leftCurrentPods = oParam.targetCurrentPods;
            this._leftMaxPods = oParam.targetMaxPods;
            this._rightCurrentPods = oParam.sourceCurrentPods;
            this._rightMaxPods = oParam.sourceMaxPods;
         }
         else
         {
            this._otherPlayerName = this._sourceName;
            this.playerLeftLook.look = oParam.sourceLook;
            this.playerRightLook.look = oParam.targetLook;
            this._rightCurrentPods = oParam.targetCurrentPods;
            this._rightMaxPods = oParam.targetMaxPods;
            this._leftCurrentPods = oParam.sourceCurrentPods;
            this._leftMaxPods = oParam.sourceMaxPods;
         }
         this.playerRightLook.direction = 3;
         this.updatePods();
         this.lbl_rightPlayerName.text = this._playerName;
         this.lbl_leftPlayerName.text = this._otherPlayerName;
         this._rightPlayerKamaExchange = 0;
         this._leftPlayerKamaExchange = 0;
         this.estimated_value_left = this.estimated_value_right = 0;
         this.updateEstimatedValue(this._leftItems,0,this.lbl_estimated_value_left);
         this.updateEstimatedValue(this._rightItems,0,this.lbl_estimated_value_right);
         this.gd_left.dataProvider = new Array();
         this.gd_left.renderer.dropValidatorFunction = this.dropValidatorFalse;
         this.gd_left.renderer.processDropFunction = this.processDropNull;
         this.gd_left.renderer.removeDropSourceFunction = this.removeDropSource;
         this.gd_right.dataProvider = new Array();
         this.gd_right.renderer.dropValidatorFunction = this.dropValidator;
         this.gd_right.renderer.processDropFunction = this.processDrop;
         this.gd_right.renderer.removeDropSourceFunction = this.removeDropSource;
         this.gd_right.mouseEnabled = true;
         if(oParam.sourceCurrentPods > 0)
         {
            this.uiApi.addComponentHook(this.tx_podsBar_left,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_podsBar_left,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_podsBar_right,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_podsBar_right,ComponentHookList.ON_ROLL_OUT);
         }
         else
         {
            this.tx_podsBar_left.visible = false;
            this.tx_podsBar_right.visible = false;
         }
      }
      
      private function redWink(top:Boolean) : void {
         if(top)
         {
            this._myTopTimer.start();
            this._myTopTimer.addEventListener(TimerEvent.TIMER,this.topTimerHandler);
            this._myTopTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.topCompleteHandler);
         }
         else
         {
            this._myBottomTimer.start();
            this._myBottomTimer.addEventListener(TimerEvent.TIMER,this.bottomTimerHandler);
            this._myBottomTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.bottomCompleteHandler);
         }
      }
      
      private function topTimerHandler(e:TimerEvent) : void {
         if(this._redTop)
         {
            this.tx_gridLeftTop.transform.colorTransform = new ColorTransform();
            this.tx_bgLeftTop.transform.colorTransform = new ColorTransform();
            this._redTop = false;
         }
         else
         {
            this.tx_gridLeftTop.transform.colorTransform = new ColorTransform(1,1,1,1,150,-200,-200,0);
            this.tx_bgLeftTop.transform.colorTransform = new ColorTransform(1,1,1,1,150,-200,-200,-150);
            this._redTop = true;
         }
      }
      
      private function topCompleteHandler(e:TimerEvent) : void {
         this.tx_gridLeftTop.transform.colorTransform = new ColorTransform();
         this._redTop = false;
         this._myTopTimer.reset();
      }
      
      private function bottomTimerHandler(e:TimerEvent) : void {
         if(this._redBottom)
         {
            this.tx_gridLeftBottom.transform.colorTransform = new ColorTransform();
            this.tx_bgLeftBottom.transform.colorTransform = new ColorTransform();
            this._redBottom = false;
         }
         else
         {
            this.tx_gridLeftBottom.transform.colorTransform = new ColorTransform(1,1,1,1,150,-200,-200,0);
            this.tx_bgLeftBottom.transform.colorTransform = new ColorTransform(1,1,1,1,150,-200,-200,-150);
            this._redBottom = true;
         }
      }
      
      private function bottomCompleteHandler(e:TimerEvent) : void {
         this.tx_gridLeftBottom.transform.colorTransform = new ColorTransform();
         this._redBottom = false;
         this._myBottomTimer.reset();
      }
      
      public function onChange(target:GraphicContainer) : void {
         var value:int = this.utilApi.stringToKamas(this.input_kamaRight.text,"");
         if(value > this._currentPlayerKama)
         {
            value = this._currentPlayerKama;
            this.input_kamaRight.text = this.utilApi.kamasToString(value,"");
         }
         if((this._timerKamaDelay) && (this._timerKamaDelay.running))
         {
            this._timerKamaDelay.stop();
            this._timerKamaDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerKamaDelay);
         }
         this._timerKamaDelay = new Timer(this._timeKamaDelay,1);
         this._timerKamaDelay.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerKamaDelay);
         this.onExchangeIsReady(this.playerApi.getPlayedCharacterInfo().name,false);
         this.delayEnableValidateButton();
         this._timerKamaDelay.start();
      }
      
      private function onTimerDelayValidateButton(e:TimerEvent) : void {
         this._timerDelay.removeEventListener(TimerEvent.TIMER,this.onTimerDelayValidateButton);
         this.checkAcceptButton();
      }
      
      private function onTimerKamaDelay(e:TimerEvent) : void {
         this._timerKamaDelay.removeEventListener(TimerEvent.TIMER,this.onTimerKamaDelay);
         var value:int = this.utilApi.stringToKamas(this.input_kamaRight.text,"");
         if(value != this._rightPlayerKamaExchange)
         {
            this._rightPlayerKamaExchange = value;
            this.sysApi.sendAction(new ExchangeObjectMoveKama(this._rightPlayerKamaExchange));
         }
      }
      
      public function onObjectSelected(item:Object) : void {
         if(!this.sysApi.getOption("displayTooltips","dofus"))
         {
            if(item)
            {
               this.modCommon.createItemBox("itemBox",this.ctr_item,item);
               this.ctr_itemBlock.visible = true;
            }
            else
            {
               this.ctr_itemBlock.visible = false;
            }
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_cancel:
               if(this._playerIsReady)
               {
                  this.validateExchange(false);
               }
               else
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               break;
            case this.btn_validate:
               if(!this._playerIsReady)
               {
                  this.validateExchange(true);
               }
               break;
            case this.playerLeftLook:
               this.sysApi.sendAction(new DisplayContextualMenu(this._otherPlayerId));
               break;
            case this.playerRightLook:
               this.sysApi.sendAction(new DisplayContextualMenu(this.playerApi.id()));
               break;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var selectedItem:Object = null;
         var selectedItem2:Object = null;
         switch(target)
         {
            case this.gd_right:
               selectedItem = this.gd_right.selectedItem;
               if(selectMethod == SelectMethodEnum.DOUBLE_CLICK)
               {
                  this._itemUIDAskedToMove = selectedItem.objectUID;
                  this._itemQuantityAskedToMove = -selectedItem.quantity;
                  this.sysApi.sendAction(new ExchangeObjectMove(selectedItem.objectUID,-1));
               }
               else if(selectMethod == SelectMethodEnum.CTRL_DOUBLE_CLICK)
               {
                  this._itemUIDAskedToMove = selectedItem.objectUID;
                  this._itemQuantityAskedToMove = -selectedItem.quantity;
                  this.sysApi.sendAction(new ExchangeObjectMove(selectedItem.objectUID,-selectedItem.quantity));
               }
               else if(selectMethod == SelectMethodEnum.ALT_DOUBLE_CLICK)
               {
                  this._waitingObject = selectedItem;
                  this.modCommon.openQuantityPopup(1,this._waitingObject.quantity,this._waitingObject.quantity,this.onAltValidQty);
               }
               else
               {
                  this.onObjectSelected(selectedItem);
               }
               
               
               break;
            case this.gd_left:
               selectedItem2 = this.gd_left.selectedItem;
               this.onObjectSelected(selectedItem2);
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         var pos:Object = new Object();
         pos.point = LocationEnum.POINT_BOTTOM;
         pos.relativePoint = LocationEnum.POINT_TOP;
         switch(target)
         {
            case this.tx_podsBar_left:
               tooltipText = this.uiApi.getText("ui.common.player.weight",this.utilApi.kamasToString(this._leftCurrentPods + this._leftExchangePods,""),this.utilApi.kamasToString(this._leftMaxPods,""));
               break;
            case this.tx_podsBar_right:
               tooltipText = this.uiApi.getText("ui.common.player.weight",this.utilApi.kamasToString(this._rightCurrentPods + this._rightExchangePods,""),this.utilApi.kamasToString(this._rightMaxPods,""));
               break;
            case this.input_kamaLeft:
               tooltipText = this.uiApi.getText("ui.exchange.kamas");
               break;
            case this.lbl_estimated_left:
            case this.lbl_estimated_value_left:
            case this.lbl_estimated_right:
            case this.lbl_estimated_value_right:
               tooltipText = this.uiApi.getText("ui.exchange.estimatedValue.description");
               break;
            case this.tx_estimated_value_warning_left:
            case this.tx_estimated_value_warning_right:
               tooltipText = this.uiApi.getText("ui.exchange.warning");
               break;
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:Object) : void {
         if(target == this.playerLeftLook)
         {
            this.sysApi.sendAction(new DisplayContextualMenu(this._otherPlayerId));
         }
         else if(target == this.playerRightLook)
         {
            this.sysApi.sendAction(new DisplayContextualMenu(this.playerApi.id()));
         }
         
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         var itemTooltipSettings:ItemTooltipSettings = null;
         var settings:Object = null;
         var setting:String = null;
         if(item.data)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            settings = new Object();
            for each(setting in this.sysApi.getObjectVariables(itemTooltipSettings))
            {
               settings[setting] = itemTooltipSettings[setting];
            }
            settings.ref = item.container;
            this.uiApi.showTooltip(item.data,item.container,false,"standard",8,0,0,"itemName",null,settings,"ItemInfo");
         }
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onItemRightClick(target:Object, item:Object) : void {
         if(item.data == null)
         {
            return;
         }
         var data:Object = item.data;
         var contextMenu:Object = this.menuApi.create(data);
         var itemTooltipSettings:ItemTooltipSettings = this.sysApi.getData("itemTooltipSettings",true) as ItemTooltipSettings;
         if(!itemTooltipSettings)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,true);
         }
         var disabled:Boolean = contextMenu.content[0].disabled;
         this.modContextMenu.createContextMenu(contextMenu);
      }
      
      public function unload() : void {
         if(this._timerPosButtons)
         {
            this._timerPosButtons.removeEventListener(TimerEvent.TIMER,this.onTimerDelayValidateButton);
            this._timerPosButtons.stop();
            this._timerPosButtons = null;
         }
         if(this._timerDelay)
         {
            this._timerDelay.removeEventListener(TimerEvent.TIMER,this.onTimerDelayValidateButton);
            this._timerDelay.stop();
            this._timerDelay = null;
         }
         this._myTopTimer.removeEventListener(TimerEvent.TIMER,this.topTimerHandler);
         this._myTopTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.topCompleteHandler);
         this._myBottomTimer.removeEventListener(TimerEvent.TIMER,this.bottomTimerHandler);
         this._myBottomTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.bottomCompleteHandler);
         this.storageApi.removeAllItemMasks("exchange");
         this.storageApi.releaseHooks();
         if(this._timerKamaDelay)
         {
            this._timerKamaDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerKamaDelay);
         }
         this.uiApi.hideTooltip();
         this.uiApi.unloadUi("itemBox");
         if(!this._hasExchangeResult)
         {
            this.sysApi.sendAction(new ExchangeRefuse());
         }
         this.sysApi.sendAction(new CloseInventory());
         if(this._success)
         {
            this.sysApi.dispatchHook(TextInformation,this.uiApi.getText("ui.exchange.success"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
         }
         else
         {
            this.sysApi.dispatchHook(TextInformation,this.uiApi.getText("ui.exchange.cancel"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
         }
         this.sysApi.enableWorldInteraction();
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case ShortcutHookListEnum.CLOSE_UI:
            case ShortcutHookListEnum.VALID_UI:
               return true;
            default:
               return false;
         }
      }
      
      public function dropValidatorFalse(target:Object, data:Object, source:Object) : Boolean {
         return false;
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean {
         if(target.getUi().name != source.getUi().name)
         {
            return true;
         }
         return false;
      }
      
      public function removeDropSource(target:Object) : void {
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void {
         if(this.dropValidator(target,data,source))
         {
            this._itemUIDAskedToMove = data.objectUID;
            this._waitingObject = data;
            if(data.quantity > 1)
            {
               this.modCommon.openQuantityPopup(1,data.quantity,data.quantity,this.onValidQty);
            }
            else
            {
               this.onValidQty(1);
            }
         }
      }
      
      public function processDropNull(target:Object, data:Object, source:Object) : void {
      }
      
      private function delayEnableValidateButton() : void {
         if((this._timerDelay) && (this._timerDelay.running))
         {
            this._timerDelay.stop();
         }
         this._timerDelay = new Timer(this._timeDelay,1);
         this._timerDelay.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerDelayValidateButton);
         this.btn_validate.disabled = true;
         this._timerDelay.start();
      }
      
      protected function checkAcceptButton() : void {
         if((this.gd_left.dataProvider.length > 0) || (this.gd_right.dataProvider.length > 0) || (this._rightPlayerKamaExchange > 0) || (this._leftPlayerKamaExchange > 0))
         {
            this.btn_validate.disabled = false;
         }
         else
         {
            this.btn_validate.disabled = true;
         }
      }
      
      private function addItemInLeftGrid(pItemWrapper:Object) : void {
         var item:Object = this.dataApi.getItem(pItemWrapper.objectGID);
         this._leftExchangePods = this._leftExchangePods - pItemWrapper.quantity * pItemWrapper.weight;
         this._rightExchangePods = this._rightExchangePods + pItemWrapper.quantity * pItemWrapper.weight;
         this.updatePods();
         this._leftItems.push(pItemWrapper);
         this.gd_left.dataProvider = this._leftItems;
         this.updateEstimatedValue(this._leftItems,this._leftPlayerKamaExchange,this.lbl_estimated_value_left);
         this.redWink(false);
      }
      
      private function addItemInRightGrid(pItemWrapper:Object) : void {
         var item:Object = this.dataApi.getItem(pItemWrapper.objectGID);
         this._leftExchangePods = this._leftExchangePods + pItemWrapper.quantity * pItemWrapper.weight;
         this._rightExchangePods = this._rightExchangePods - pItemWrapper.quantity * pItemWrapper.weight;
         this.updatePods();
         this._rightItems.push(pItemWrapper);
         this.gd_right.dataProvider = this._rightItems;
         this.updateEstimatedValue(this._rightItems,this._rightPlayerKamaExchange,this.lbl_estimated_value_right);
      }
      
      private function removeItemInRightGrid(pItemUID:int) : void {
         var index:String = null;
         var i:String = null;
         var item:Object = null;
         for(i in this._rightItems)
         {
            if(this._rightItems[i].objectUID == pItemUID)
            {
               index = i;
               break;
            }
         }
         if(index)
         {
            item = this.dataApi.getItem(this._rightItems[index].objectGID);
            this._leftExchangePods = this._leftExchangePods - this._rightItems[index].quantity * this._rightItems[index].weight;
            this._rightExchangePods = this._rightExchangePods + this._rightItems[index].quantity * this._rightItems[index].weight;
            this.updatePods();
            this._rightItems.splice(index,1);
            this.gd_right.dataProvider = this._rightItems;
            this.updateEstimatedValue(this._rightItems,this._rightPlayerKamaExchange,this.lbl_estimated_value_right);
         }
      }
      
      private function removeItemInLeftGrid(pItemUID:int) : void {
         var index:String = null;
         var i:String = null;
         var item:Object = null;
         for(i in this._leftItems)
         {
            if(this._leftItems[i].objectUID == pItemUID)
            {
               index = i;
               break;
            }
         }
         if(index)
         {
            item = this.dataApi.getItem(this._leftItems[index].objectGID);
            this._leftExchangePods = this._leftExchangePods + this._leftItems[index].quantity * this._leftItems[index].weight;
            this._rightExchangePods = this._rightExchangePods - this._leftItems[index].quantity * this._leftItems[index].weight;
            this.updatePods();
            this._leftItems.splice(index,1);
            this.gd_left.dataProvider = this._leftItems;
            this.updateEstimatedValue(this._leftItems,this._leftPlayerKamaExchange,this.lbl_estimated_value_left);
            this.redWink(false);
         }
      }
      
      private function modifyItemInRightGrid(pItemWrapper:Object) : void {
         var index:String = null;
         var i:String = null;
         var item:Object = null;
         for(i in this._rightItems)
         {
            if(this._rightItems[i].objectUID == pItemWrapper.objectUID)
            {
               index = i;
               break;
            }
         }
         if(index)
         {
            item = this.dataApi.getItem(pItemWrapper.objectGID);
            this._leftExchangePods = this._leftExchangePods - this._rightItems[index].quantity * this._rightItems[index].weight;
            this._rightExchangePods = this._rightExchangePods + this._rightItems[index].quantity * this._rightItems[index].weight;
            this._leftExchangePods = this._leftExchangePods + pItemWrapper.quantity * pItemWrapper.weight;
            this._rightExchangePods = this._rightExchangePods - pItemWrapper.quantity * pItemWrapper.weight;
            this.updatePods();
            this._rightItems.splice(index,1,pItemWrapper);
            this.gd_right.dataProvider = this._rightItems;
            this.updateEstimatedValue(this._rightItems,this._rightPlayerKamaExchange,this.lbl_estimated_value_right);
         }
      }
      
      private function modifyItemInLeftGrid(pItemWrapper:Object) : void {
         var index:String = null;
         var i:String = null;
         var item:Object = null;
         for(i in this._leftItems)
         {
            if(this._leftItems[i].objectUID == pItemWrapper.objectUID)
            {
               index = i;
               break;
            }
         }
         if(index)
         {
            item = this.dataApi.getItem(pItemWrapper.objectGID);
            this._leftExchangePods = this._leftExchangePods + this._leftItems[index].quantity * this._leftItems[index].weight;
            this._rightExchangePods = this._rightExchangePods - this._leftItems[index].quantity * this._leftItems[index].weight;
            this._leftExchangePods = this._leftExchangePods - pItemWrapper.quantity * pItemWrapper.weight;
            this._rightExchangePods = this._rightExchangePods + pItemWrapper.quantity * pItemWrapper.weight;
            this.updatePods();
            this._leftItems.splice(index,1,pItemWrapper);
            this.gd_left.dataProvider = this._leftItems;
            this.updateEstimatedValue(this._leftItems,this._leftPlayerKamaExchange,this.lbl_estimated_value_left);
            this.redWink(false);
         }
      }
      
      private function validateExchange(ready:Boolean) : void {
         var value:* = 0;
         if((this._timerKamaDelay) && (this._timerKamaDelay.running))
         {
            value = this.utilApi.stringToKamas(this.input_kamaRight.text,"");
            if(value != this._rightPlayerKamaExchange)
            {
               this._rightPlayerKamaExchange = value;
               this.sysApi.sendAction(new ExchangeObjectMoveKama(this._rightPlayerKamaExchange));
            }
         }
         else
         {
            this.sysApi.sendAction(new ExchangeReady(ready));
         }
      }
      
      private function changeBackgroundGrid(value:String, grid:Object) : void {
         switch(value)
         {
            case EXCHANGE_COLOR_OK:
               switch(grid)
               {
                  case this.gd_left:
                     this.tx_gridLeftTop.gotoAndStop = 2;
                     this.tx_gridLeftBottom.gotoAndStop = 2;
                     break;
                  case this.gd_right:
                     this.tx_gridRightTop.gotoAndStop = 2;
                     this.tx_gridRightBottom.gotoAndStop = 2;
                     break;
               }
               break;
            case EXCHANGE_COLOR_CHANGE:
               switch(grid)
               {
                  case this.gd_left:
                     this.tx_gridLeftTop.gotoAndStop = 1;
                     this.tx_gridLeftBottom.gotoAndStop = 1;
                     break;
                  case this.gd_right:
                     this.tx_gridRightTop.gotoAndStop = 1;
                     this.tx_gridRightBottom.gotoAndStop = 1;
                     break;
               }
               break;
         }
      }
      
      private function updatePods() : void {
         this.tx_podsBar_left.gotoAndStop = Math.min(100,Math.floor(100 * (this._leftCurrentPods + this._leftExchangePods) / this._leftMaxPods));
         this.tx_podsBar_right.gotoAndStop = Math.min(100,Math.floor(100 * (this._rightCurrentPods + this._rightExchangePods) / this._rightMaxPods));
      }
      
      private function updateEstimatedValue(pItemsList:Array, pKamas:int, pLabel:Label) : void {
         var i:String = null;
         var averagePrice:* = 0;
         var itemsValue:Number = 0;
         for(i in pItemsList)
         {
            averagePrice = this.averagePricesApi.getItemAveragePrice(pItemsList[i].objectGID);
            if(averagePrice > 0)
            {
               itemsValue = itemsValue + averagePrice * pItemsList[i].quantity;
            }
         }
         pLabel.text = this.utilApi.kamasToString(itemsValue + pKamas);
         if(pLabel == this.lbl_estimated_value_left)
         {
            this.estimated_value_left = itemsValue;
         }
         else if(pLabel == this.lbl_estimated_value_right)
         {
            this.estimated_value_right = itemsValue;
         }
         
         this.checkFairTrade();
      }
      
      private function checkFairTrade() : void {
         var fairTrade:Boolean = true;
         if((this.estimated_value_left > 0) && (this.estimated_value_left >= 2 * this.estimated_value_right))
         {
            this.tx_estimated_value_warning_left.visible = true;
            this.lbl_estimated_value_left.x = this._lbl_estimated_value_left_default_x - 20;
            fairTrade = false;
         }
         else
         {
            this.tx_estimated_value_warning_left.visible = false;
            this.lbl_estimated_value_left.x = this._lbl_estimated_value_left_default_x;
         }
         if((this.estimated_value_right > 0) && (this.estimated_value_right >= 2 * this.estimated_value_left))
         {
            this.tx_estimated_value_warning_right.visible = true;
            this.lbl_estimated_value_right.x = this._lbl_estimated_value_right_default_x - 20;
            fairTrade = false;
         }
         else
         {
            this.tx_estimated_value_warning_right.visible = false;
            this.lbl_estimated_value_right.x = this._lbl_estimated_value_right_default_x;
         }
         if(!fairTrade)
         {
            this.lbl_estimated_value_left.cssClass = this.lbl_estimated_value_right.cssClass = "rightred";
         }
         else
         {
            this.lbl_estimated_value_left.cssClass = this.lbl_estimated_value_right.cssClass = "right";
         }
      }
      
      private function onExchangeIsReady(playerName:String, isReady:Boolean) : void {
         if(playerName != this._playerName)
         {
            if(isReady)
            {
               this.changeBackgroundGrid(EXCHANGE_COLOR_OK,this.gd_left);
            }
            else
            {
               this.changeBackgroundGrid(EXCHANGE_COLOR_CHANGE,this.gd_left);
            }
         }
         else
         {
            this._playerIsReady = isReady;
            if(isReady)
            {
               this.changeBackgroundGrid(EXCHANGE_COLOR_OK,this.gd_right);
            }
            else
            {
               this.changeBackgroundGrid(EXCHANGE_COLOR_CHANGE,this.gd_right);
            }
         }
      }
      
      private function onAskExchangeMoveObject(itemUID:int, itemQuantity:int) : void {
         this._itemUIDAskedToMove = itemUID;
         this._itemQuantityAskedToMove = itemQuantity;
      }
      
      private function onExchangeObjectModified(pObjectModified:Object) : void {
         this.modifyItemInLeftGrid(pObjectModified);
         this.modifyItemInRightGrid(pObjectModified);
         this.gd_left.updateItems();
         this.gd_right.updateItems();
         this.storageApi.addItemMask(pObjectModified.objectUID,"exchange",pObjectModified.quantity);
         this.storageApi.releaseHooks();
         this.checkAcceptButton();
         this.delayEnableValidateButton();
      }
      
      private function onExchangeObjectAdded(itemWrapper:Object) : void {
         this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
         if((this._itemUIDAskedToMove == itemWrapper.objectUID) && (this._itemQuantityAskedToMove == itemWrapper.quantity))
         {
            this.addItemInRightGrid(itemWrapper);
         }
         else
         {
            this.addItemInLeftGrid(itemWrapper);
         }
         this.storageApi.addItemMask(itemWrapper.objectUID,"exchange",itemWrapper.quantity);
         this.storageApi.releaseHooks();
         this.delayEnableValidateButton();
      }
      
      private function onExchangeObjectRemoved(itemUID:int) : void {
         this.soundApi.playSound(SoundTypeEnum.SWITCH_LEFT_TO_RIGHT);
         this.removeItemInRightGrid(itemUID);
         this.removeItemInLeftGrid(itemUID);
         this.storageApi.removeItemMask(itemUID,"exchange");
         this.storageApi.releaseHooks();
         this.checkAcceptButton();
         this.delayEnableValidateButton();
      }
      
      private function onExchangeKamaModified(kamas:uint, remote:Boolean) : void {
         if(remote)
         {
            this.input_kamaLeft.text = this.utilApi.kamasToString(kamas,"");
            this._leftPlayerKamaExchange = kamas;
            this.updateEstimatedValue(this._leftItems,this._leftPlayerKamaExchange,this.lbl_estimated_value_left);
            this.redWink(true);
         }
         else
         {
            this.input_kamaRight.text = this.utilApi.kamasToString(kamas,"");
            this._rightPlayerKamaExchange = kamas;
            this.updateEstimatedValue(this._rightItems,this._rightPlayerKamaExchange,this.lbl_estimated_value_right);
         }
         this.checkAcceptButton();
         this.delayEnableValidateButton();
      }
      
      public function onDoubleClickItemInventory(pItem:Object, pQuantity:int = 1) : void {
         this._itemUIDAskedToMove = pItem.objectUID;
         this._waitingObject = pItem;
         this.onValidQty(pQuantity);
      }
      
      private function onValidQty(qty:Number) : void {
         this._itemQuantityAskedToMove = qty;
         this.sysApi.sendAction(new ExchangeObjectMove(this._waitingObject.objectUID,qty));
      }
      
      private function onAltValidQty(qty:Number) : void {
         this._itemUIDAskedToMove = this._waitingObject.objectUID;
         this._itemQuantityAskedToMove = -qty;
         this.sysApi.sendAction(new ExchangeObjectMove(this._waitingObject.objectUID,-qty));
      }
      
      private function onTimerPosButtons(pEvent:TimerEvent) : void {
         this.btn_validate.x = this._posXValid;
         this.btn_validate.y = this._posYValid;
         this.btn_cancel.x = this._posXCancel;
         this.btn_cancel.y = this._posYCancel;
         this._timerPosButtons.stop();
         this._timerPosButtons.removeEventListener(TimerEvent.TIMER,this.onTimerPosButtons);
         this._timerPosButtons = null;
      }
      
      private function onExchangeLeave(success:Boolean) : void {
         this._hasExchangeResult = true;
         this._success = success;
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
