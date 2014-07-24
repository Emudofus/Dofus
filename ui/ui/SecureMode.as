package ui
{
   import flash.utils.Dictionary;
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.SecurityApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.TextArea;
   import d2components.Texture;
   import d2components.ButtonContainer;
   import d2components.ComboBox;
   import d2components.Input;
   import d2enums.ComponentHookList;
   
   public class SecureMode extends Object
   {
      
      public function SecureMode() {
         this._initialValues = new Dictionary();
         super();
      }
      
      public static const STATE_START:uint = 0;
      
      public static const STATE_UNLOCK:uint = 1;
      
      public static const STATE_COMPUTER_NAME:uint = 2;
      
      public static const STATE_SEND_EMAIL:uint = 3;
      
      public static const STATE_EMAIL:uint = 4;
      
      public static const STATE_ENTER_CODE:uint = 5;
      
      public static const STATE_END:uint = 6;
      
      public static const STATE_FATAL_ERROR:uint = 7;
      
      public static const STATE_ERROR:uint = 8;
      
      public static const STATE_NEED_RESTART:uint = 9;
      
      private var _step:uint;
      
      private var _nextStep:uint;
      
      private var _isComputerUnlock:Boolean;
      
      private var _computerName:String;
      
      private var _maxProcessStep:uint;
      
      private var _currentProcessStep:uint;
      
      private var _currentWebServiceData:Object;
      
      private var _onErrorStep:int = -1;
      
      private var _initialValues:Dictionary;
      
      private var _secureModeNeedReboot:Object;
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var securityApi:SecurityApi;
      
      public var mainCtr:GraphicContainer;
      
      public var inputCtr:GraphicContainer;
      
      public var lbl_moreInfo:Label;
      
      public var lbl_inputInfo:TextArea;
      
      public var tx_loading:Texture;
      
      public var lbl_title:Label;
      
      public var lbl_content:TextArea;
      
      public var lbl_content2:TextArea;
      
      public var lbl_input:Label;
      
      public var btn1:ButtonContainer;
      
      public var btn_lbl_btn1:Label;
      
      public var btn2:ButtonContainer;
      
      public var btn_lbl_btn2:Label;
      
      public var btn3:ButtonContainer;
      
      public var btn_lbl_btn3:Label;
      
      public var combo:ComboBox;
      
      public var input:Input;
      
      public function main(secureModeNeedReboot:Object) : void {
         var target:GraphicContainer = null;
         var prop:Object = null;
         this.uiApi.addComponentHook(this.lbl_moreInfo,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.input,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.combo,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.combo,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.combo,ComponentHookList.ON_ROLL_OUT);
         this._secureModeNeedReboot = secureModeNeedReboot;
         var targets:Array = [this.btn1,this.btn2,this.btn3];
         var properties:Array = [
            {
               "get":"anchorY",
               "set":"y"
            }];
         for each(target in targets)
         {
            this._initialValues[target] = new Dictionary();
            for each(prop in properties)
            {
               this._initialValues[target][prop] = target[prop.get];
            }
         }
         this._computerName = this.uiApi.getText("ui.common.houseWord");
         if((secureModeNeedReboot) && (secureModeNeedReboot.reboot))
         {
            this.step = STATE_NEED_RESTART;
         }
         else
         {
            this.step = STATE_START;
         }
      }
      
      public function set step(stepId:uint) : void {
         var target:* = undefined;
         var prop:* = undefined;
         var comboDp:Array = null;
         var reverseRef:Array = null;
         if(!this.btn1)
         {
            return;
         }
         for(target in this._initialValues)
         {
            for(prop in this._initialValues[target])
            {
               target[prop.set] = this._initialValues[target][prop];
            }
         }
         this.btn1.visible = false;
         this.btn2.visible = false;
         this.btn3.visible = false;
         this.btn1.disabled = false;
         this.btn2.disabled = false;
         this.btn3.disabled = false;
         this.inputCtr.visible = false;
         this.lbl_inputInfo.visible = false;
         this.tx_loading.visible = false;
         this.tx_loading.gotoAndStop = 0;
         this.lbl_content.visible = true;
         this.lbl_content2.visible = false;
         this.combo.visible = false;
         switch(stepId)
         {
            case STATE_START:
               this.mainCtr.height = 580;
               this.lbl_title.text = this.uiApi.getText("ui.modeSecure.title");
               this.lbl_content.text = this.uiApi.getText("ui.modeSecure.startDesc1");
               this.lbl_content2.text = this.uiApi.getText("ui.modeSecure.startDesc2");
               this.lbl_content2.visible = true;
               this.btn1.visible = true;
               this.btn2.visible = true;
               this.btn2.y = -210;
               this.btn_lbl_btn1.text = this.uiApi.getText("ui.modeSecure.exit");
               this.btn_lbl_btn2.text = this.uiApi.getText("ui.modeSecure.unlock");
               break;
            case STATE_UNLOCK:
               this._currentProcessStep = 0;
               this._maxProcessStep = 5;
               this.mainCtr.height = 500;
               this.lbl_title.text = this.uiApi.getText("ui.modeSecure.title");
               this.lbl_content.text = this.uiApi.getText("ui.modeSecure.unlockDesc");
               this.btn1.visible = true;
               this.btn2.visible = true;
               this.btn3.visible = true;
               this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.cancel");
               this.btn_lbl_btn2.text = this.uiApi.getText("ui.modeSecure.unlockThisSession");
               this.btn_lbl_btn3.text = this.uiApi.getText("ui.modeSecure.unlockThisComputer");
               this._isComputerUnlock = false;
               break;
            case STATE_COMPUTER_NAME:
               this._currentProcessStep = 1;
               this._maxProcessStep = 6;
               this.mainCtr.height = 400;
               this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockComputerTitle").replace("%1",this._currentProcessStep).replace("%2",this._maxProcessStep);
               this.lbl_content.text = this.uiApi.getText("ui.modeSecure.computerNameDesc");
               this.btn1.visible = true;
               this.btn2.visible = true;
               this.lbl_input.text = this.uiApi.getText("ui.modeSecure.computerName");
               this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.cancel");
               this.btn_lbl_btn2.text = this.uiApi.getText("ui.common.continue");
               this.input.restrict = null;
               this.input.text = this._computerName;
               this.input.focus();
               this.inputCtr.y = 145;
               this.inputCtr.visible = true;
               comboDp = [
                  {
                     "level":2,
                     "label":this.uiApi.getText("ui.modeSecure.level.max")
                  },
                  {
                     "level":1,
                     "label":this.uiApi.getText("ui.modeSecure.level.medium")
                  },
                  {
                     "level":0,
                     "label":this.uiApi.getText("ui.modeSecure.level.min")
                  }];
               reverseRef = [];
               reverseRef[2] = 0;
               reverseRef[1] = 1;
               reverseRef[2] = 2;
               this.combo.dataProvider = comboDp;
               this.combo.visible = true;
               this.combo.selectedIndex = reverseRef[this.securityApi.getShieldLevel()];
               this._isComputerUnlock = true;
               break;
            case STATE_EMAIL:
               this._currentProcessStep = this._currentProcessStep + 1;
               this.mainCtr.height = 450;
               if(this._isComputerUnlock)
               {
                  this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockComputerTitle").replace("%1",this._currentProcessStep).replace("%2",this._maxProcessStep);
               }
               else
               {
                  this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockSessionTitle").replace("%1",this._currentProcessStep).replace("%2",this._maxProcessStep);
               }
               this.lbl_content.text = this.uiApi.getText("ui.modeSecure.mailDesc");
               this.btn1.visible = true;
               this.btn2.visible = true;
               this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.cancel");
               this.btn_lbl_btn2.text = this.uiApi.getText("ui.modeSecure.sendEmail");
               break;
            case STATE_SEND_EMAIL:
               this._currentProcessStep = this._currentProcessStep + 1;
               this.mainCtr.height = 300;
               if(this._isComputerUnlock)
               {
                  this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockComputerTitle").replace("%1",this._currentProcessStep).replace("%2",this._maxProcessStep);
               }
               else
               {
                  this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockSessionTitle").replace("%1",this._currentProcessStep).replace("%2",this._maxProcessStep);
               }
               this.tx_loading.visible = true;
               this.lbl_inputInfo.visible = true;
               this.lbl_content.visible = false;
               this.tx_loading.gotoAndPlay = 0;
               this.mainCtr.height = 300;
               this.lbl_inputInfo.y = -45;
               this.lbl_inputInfo.text = this.uiApi.getText("ui.modeSecure.sendEmailDesc");
               break;
            case STATE_ENTER_CODE:
               this._currentProcessStep = this._currentProcessStep + 1;
               this._onErrorStep = STATE_ENTER_CODE;
               this._nextStep = STATE_END;
               this.mainCtr.height = 450;
               if(this._isComputerUnlock)
               {
                  this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockComputerTitle").replace("%1",this._currentProcessStep).replace("%2",this._maxProcessStep);
                  this.lbl_content.text = this.uiApi.getText("ui.modeSecure.enterCodeDesc").replace("%1",this._currentWebServiceData.domain);
               }
               else
               {
                  this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockSessionTitle").replace("%1",this._currentProcessStep).replace("%2",this._maxProcessStep);
                  this.lbl_content.text = this.uiApi.getText("ui.modeSecure.enterCodeSessionDesc").replace("%1",this._currentWebServiceData.domain);
               }
               this.btn1.visible = true;
               this.btn2.visible = true;
               this.lbl_inputInfo.visible = true;
               this.lbl_inputInfo.y = 10;
               this.lbl_inputInfo.text = this.uiApi.getText("ui.modeSecure.codeInfo");
               this.lbl_input.text = this.uiApi.getText("ui.modeSecure.secureCode");
               this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.cancel");
               this.btn_lbl_btn2.text = this.uiApi.getText("ui.common.validation");
               this.input.restrict = "A-Za-z0-9";
               this.input.text = "";
               this.input.focus();
               this.inputCtr.y = 160;
               this.inputCtr.visible = true;
               break;
            case STATE_END:
               this._currentProcessStep = this._currentProcessStep + 1;
               this.mainCtr.height = 500;
               if(this._isComputerUnlock)
               {
                  this.lbl_content.text = this.uiApi.getText("ui.modeSecure.endComputerDesc").replace("%1",this._computerName);
                  this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockComputerTitle").replace("%1",this._currentProcessStep).replace("%2",this._maxProcessStep);
               }
               else
               {
                  this.lbl_content.text = this.uiApi.getText("ui.modeSecure.endSessionDesc");
                  this.lbl_title.text = this.uiApi.getText("ui.modeSecure.unlockSessionTitle").replace("%1",this._currentProcessStep).replace("%2",this._maxProcessStep);
               }
               this.btn1.visible = true;
               this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.play");
               break;
            case STATE_NEED_RESTART:
               if(this._secureModeNeedReboot)
               {
                  this._secureModeNeedReboot.reboot = true;
               }
               this.mainCtr.height = 300;
               this.btn1.visible = true;
               this.btn2.visible = true;
               this.lbl_title.text = this.uiApi.getText("ui.popup.warning");
               this.lbl_content.text = this.uiApi.getText("ui.secureMode.error.checkCode.202");
               this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.continue");
               this.btn_lbl_btn2.text = this.uiApi.getText("ui.common.restartGame");
               break;
            case STATE_FATAL_ERROR:
               this.mainCtr.height = 300;
               this.lbl_title.text = this.uiApi.getText("ui.common.error");
               this.btn1.visible = true;
               this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.close");
               break;
            case STATE_ERROR:
               this.mainCtr.height = 300;
               this.lbl_title.text = this.uiApi.getText("ui.common.error");
               this.btn1.visible = true;
               this.btn_lbl_btn1.text = this.uiApi.getText("ui.common.continue");
               break;
         }
         this.uiApi.me().render();
         this._step = stepId;
      }
      
      public function get step() : uint {
         return this._step;
      }
      
      public function onRelease(target:GraphicContainer) : void {
         if(target == this.lbl_moreInfo)
         {
            this.sysApi.goToSupportFAQ(this.uiApi.getText("ui.link.support.faq.shield"));
            return;
         }
         switch(this._step)
         {
            case STATE_START:
               switch(target)
               {
                  case this.btn1:
                     this.uiApi.unloadUi(this.uiApi.me().name);
                     break;
                  case this.btn2:
                     this.step = STATE_UNLOCK;
                     break;
               }
               break;
            case STATE_UNLOCK:
               switch(target)
               {
                  case this.btn1:
                     this.step = STATE_START;
                     break;
                  case this.btn2:
                     this.step = STATE_EMAIL;
                     break;
                  case this.btn3:
                     this.step = STATE_COMPUTER_NAME;
                     break;
               }
               break;
            case STATE_COMPUTER_NAME:
               switch(target)
               {
                  case this.btn1:
                     this.step = STATE_UNLOCK;
                     break;
                  case this.btn2:
                     this._computerName = this.input.text;
                     this.step = STATE_EMAIL;
                     break;
               }
               break;
            case STATE_EMAIL:
               switch(target)
               {
                  case this.btn1:
                     this._currentProcessStep = this._currentProcessStep - 2;
                     if(!this._isComputerUnlock)
                     {
                        this.step = STATE_UNLOCK;
                     }
                     else
                     {
                        this.step = STATE_COMPUTER_NAME;
                     }
                     break;
                  case this.btn2:
                     this._computerName = this.input.text;
                     this._nextStep = STATE_ENTER_CODE;
                     this.step = STATE_SEND_EMAIL;
                     this.securityApi.askSecureModeCode(this.onServiceResponse);
                     break;
               }
               break;
            case STATE_ENTER_CODE:
               switch(target)
               {
                  case this.btn1:
                     this._currentProcessStep = this._currentProcessStep - 3;
                     this.step = STATE_EMAIL;
                     break;
                  case this.btn2:
                     this.securityApi.sendSecureModeCode(this.input.text,this.onServiceResponse,this._isComputerUnlock?this._computerName:null);
                     this._nextStep = STATE_END;
                     this.step = STATE_SEND_EMAIL;
                     break;
               }
               break;
            case STATE_END:
               switch(target)
               {
                  case this.btn1:
                     this.uiApi.unloadUi(this.uiApi.me().name);
                     break;
               }
               break;
            case STATE_ERROR:
               switch(target)
               {
                  case this.btn1:
                     this.step = this._nextStep;
                     break;
               }
               break;
            case STATE_FATAL_ERROR:
               switch(target)
               {
                  case this.btn1:
                     this.uiApi.unloadUi(this.uiApi.me().name);
                     break;
               }
               break;
            case STATE_NEED_RESTART:
               switch(target)
               {
                  case this.btn1:
                     this.uiApi.unloadUi(this.uiApi.me().name);
                     break;
                  case this.btn2:
                     this.sysApi.reset();
                     break;
               }
               break;
         }
      }
      
      public function onChange(target:Input) : void {
         switch(this._step)
         {
            case STATE_COMPUTER_NAME:
               this.btn2.disabled = this.input.text.length == 0;
               break;
            case STATE_ENTER_CODE:
               this.btn2.disabled = this.input.text.length < 4;
               break;
         }
      }
      
      private function onServiceResponse(result:Object) : void {
         if(!this.lbl_content)
         {
            return;
         }
         this._currentWebServiceData = result;
         if(result.error)
         {
            if(this._onErrorStep != -1)
            {
               this._nextStep = this._onErrorStep;
            }
            this.lbl_content.text = result.text;
            this._currentProcessStep = this._currentProcessStep - 2;
            if(result.fatal)
            {
               this.step = STATE_FATAL_ERROR;
            }
            else if(!result.restart)
            {
               this.step = STATE_ERROR;
            }
            else
            {
               this.step = STATE_NEED_RESTART;
            }
            
            this._onErrorStep = -1;
         }
         else
         {
            this._onErrorStep = -1;
            this.step = this._nextStep;
         }
      }
      
      public function onSelectItem(target:ComboBox, method:uint, selected:Boolean) : void {
         this.securityApi.setShieldLevel(target.selectedItem.level);
      }
      
      public function onItemRollOver(target:ComboBox, item:*) : void {
         var help:String = null;
         switch(item.data.level)
         {
            case 0:
               help = this.uiApi.getText("ui.modeSecure.help.level.min");
               break;
            case 1:
               help = this.uiApi.getText("ui.modeSecure.help.level.medium");
               break;
            case 2:
               help = this.uiApi.getText("ui.modeSecure.help.level.max");
               break;
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(help),this.combo,false,"standard",0,2,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:ComboBox) : void {
         this.uiApi.hideTooltip();
      }
   }
}
