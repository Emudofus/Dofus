package 
{
    import flash.display.Sprite;
    import ui.Popup;
    import ui.InputPopup;
    import ui.InputComboBoxPopup;
    import ui.CheckboxPopup;
    import ui.PollPopup;
    import ui.ImagePopup;
    import ui.LargePopup;
    import ui.DelayedClosurePopup;
    import ui.QuantityPopup;
    import ui.OptionContainer;
    import ui.PasswordMenu;
    import ui.Payment;
    import ui.ItemRecipes;
    import ui.ItemsSet;
    import ui.items.RecipeItem;
    import ui.BetaMenu;
    import ui.GameMenu;
    import ui.QueuePopup;
    import ui.Recipes;
    import ui.FeedUi;
    import ui.LockedPopup;
    import ui.ItemBox;
    import ui.WebPortal;
    import ui.ItemBoxPopup;
    import ui.SecureMode;
    import ui.SecureModeIcon;
    import ui.DownloadUi;
    import d2api.UiApi;
    import d2api.ConfigApi;
    import d2api.SystemApi;
    import d2api.SecurityApi;
    import d2hooks.OpenRecipe;
    import d2hooks.OpenSet;
    import d2hooks.OpenFeed;
    import d2hooks.OpenMountFeed;
    import d2hooks.LoginQueueStatus;
    import d2hooks.QueueStatus;
    import d2hooks.OpenWebPortal;
    import d2hooks.ShowObjectLinked;
    import d2hooks.SecureModeChange;
    import d2hooks.PartInfo;
    import d2hooks.AllDownloadTerminated;
    import d2hooks.ClosePopup;
    import d2hooks.AuthenticationTicketAccepted;
    import d2hooks.GameStart;
    import options.OptionManager;
    import options.OptionItem;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2components.GraphicContainer;
    import d2enums.StrataEnum;
    import d2hooks.*;

    public class Common extends Sprite 
    {

        private static var _self:Common;

        private var include_Popup:Popup = null;
        private var include_InputPopup:InputPopup = null;
        private var include_InputComboBoxPopup:InputComboBoxPopup = null;
        private var include_CheckboxPopup:CheckboxPopup = null;
        private var include_PollPopup:PollPopup = null;
        private var include_ImagePopup:ImagePopup = null;
        private var include_LargePopup:LargePopup = null;
        private var include_DelayedClosurePopup:DelayedClosurePopup = null;
        private var include_QuantityPopup:QuantityPopup = null;
        private var include_OptionContainer:OptionContainer = null;
        private var include_PasswordMenu:PasswordMenu = null;
        private var include_Payment:Payment = null;
        private var include_ItemRecipes:ItemRecipes = null;
        private var include_ItemsSet:ItemsSet = null;
        private var include_RecipeItem:RecipeItem = null;
        private var include_BetaMenu:BetaMenu = null;
        private var include_GameMenu:GameMenu = null;
        private var include_QueuePopup:QueuePopup = null;
        private var include_Recipes:Recipes = null;
        private var include_FeedUi:FeedUi = null;
        private var include_LockedPopup:LockedPopup = null;
        private var include_ItemBox:ItemBox = null;
        private var include_WebPortal:WebPortal = null;
        private var include_ItemBoxPopup:ItemBoxPopup = null;
        private var include_SecureMode:SecureMode = null;
        private var include_SecureModeIcon:SecureModeIcon = null;
        private var include_downloadUi:DownloadUi = null;
        private var _secureModeNeedReboot:Object;
        private var _lastPage:int = -1;
        private var _popupId:uint = 0;
        private var _isFullScreen:Boolean = false;
        private var _lastFoodQuantity:int = 1;
        private var _recipeSlotsNumber:int;
        public var uiApi:UiApi;
        public var configApi:ConfigApi;
        public var sysApi:SystemApi;
        public var secureApi:SecurityApi;
        [Module(name="Ankama_ContextMenu")]
        public var modMenu:Object = null;
        private var _currentPopupNumber:int = 0;

        public function Common()
        {
            this._secureModeNeedReboot = {"reboot":false};
            super();
        }

        public static function getInstance():Common
        {
            return (_self);
        }


        public function main():void
        {
            Api.ui = this.uiApi;
            Api.system = this.sysApi;
            this.uiApi.initDefaultBinds();
            this.uiApi.addShortcutHook("toggleFullscreen", this.onToggleFullScreen);
            this.sysApi.addHook(OpenRecipe, this.onOpenItemRecipes);
            this.sysApi.addHook(OpenSet, this.onOpenItemSet);
            this.sysApi.addHook(OpenFeed, this.onOpenFeed);
            this.sysApi.addHook(OpenMountFeed, this.onOpenMountFeed);
            this.sysApi.addHook(LoginQueueStatus, this.onLoginQueueStatus);
            this.sysApi.addHook(QueueStatus, this.onQueueStatus);
            this.sysApi.addHook(OpenWebPortal, this.onOpenWebPortal);
            this.sysApi.addHook(ShowObjectLinked, this.onShowObjectLinked);
            this.sysApi.addHook(SecureModeChange, this.onSecureModeChange);
            this.sysApi.addHook(PartInfo, this.onPartInfo);
            this.sysApi.addHook(AllDownloadTerminated, this.onAllDownloadTerminated);
            this.sysApi.addHook(ClosePopup, this.onClosePopup);
            this.sysApi.addHook(AuthenticationTicketAccepted, this.onConnectionStart);
            this.sysApi.addHook(GameStart, this.onGameStart);
            if ((((this.sysApi.getBuildType() == 1)) && (((!(this.sysApi.getConfigKey("eventMode"))) || ((this.sysApi.getConfigKey("eventMode") == "false"))))))
            {
                this.uiApi.loadUi("betaMenu", "betaMenu", null, 3);
            };
            this.uiApi.loadUi("gameMenu", "gameMenu", null, 3);
            _self = this;
        }

        public function get lastFoodQuantity():int
        {
            return (this._lastFoodQuantity);
        }

        public function set lastFoodQuantity(qty:int):void
        {
            this._lastFoodQuantity = qty;
        }

        public function get recipeSlotsNumber():int
        {
            return (this._recipeSlotsNumber);
        }

        public function set recipeSlotsNumber(value:int):void
        {
            this._recipeSlotsNumber = value;
        }

        public function addOptionItem(id:String, name:String, description:String, ui:String=null, childItems:Array=null):void
        {
            OptionManager.getInstance().addItem(new OptionItem(id, name, description, ui, childItems));
        }

        public function onAllDownloadTerminated():void
        {
            this.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.split.rebootConfirm", []), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmRestart, null], this.onConfirmRestart);
        }

        private function onConfirmRestart():void
        {
            this.sysApi.reset();
        }

        private function onClosePopup():void
        {
            this._currentPopupNumber--;
        }

        public function openPopup(title:String, content:String, buttonText:Array, buttonCallback:Array=null, onEnterKey:Function=null, onCancel:Function=null, image:Object=null, largeText:Boolean=false, useHyperLink:Boolean=false):String
        {
            this._currentPopupNumber++;
            var params:Object = new Object();
            params.title = title;
            params.content = content;
            params.buttonText = buttonText;
            params.buttonCallback = ((buttonCallback) ? buttonCallback : new Array());
            params.onEnterKey = onEnterKey;
            params.onCancel = onCancel;
            params.image = image;
            params.useHyperLink = useHyperLink;
            params.hideModalContainer = (this._currentPopupNumber > 1);
            var popupName:String = ("popup" + ++this._popupId);
            if (image == null)
            {
                if (largeText)
                {
                    this.uiApi.loadUi("largePopup", popupName, params, 3);
                }
                else
                {
                    this.uiApi.loadUi("popup", popupName, params, 3);
                };
            }
            else
            {
                this.uiApi.loadUi("imagepopup", popupName, params, 3);
            };
            return (popupName);
        }

        public function openNoButtonPopup(title:String, content:String):String
        {
            this._currentPopupNumber++;
            var params:Object = new Object();
            params.title = title;
            params.content = content;
            params.noButton = true;
            params.hideModalContainer = (this._currentPopupNumber > 1);
            var popupName:String = ("popup" + ++this._popupId);
            this.uiApi.loadUi("popup", popupName, params, 3);
            return (popupName);
        }

        public function openTextPopup(title:String, content:String, buttonText:Array, buttonCallback:Array=null, onEnterKey:Function=null, onCancel:Function=null):String
        {
            this._currentPopupNumber++;
            var params:Object = new Object();
            params.title = title;
            params.content = content;
            params.buttonText = buttonText;
            params.buttonCallback = ((buttonCallback) ? buttonCallback : new Array());
            params.onEnterKey = onEnterKey;
            params.onCancel = onCancel;
            params.noHtml = true;
            params.hideModalContainer = (this._currentPopupNumber > 1);
            var popupName:String = ("popup" + ++this._popupId);
            this.uiApi.loadUi("popup", popupName, params, 3);
            return (popupName);
        }

        public function openDelayedClosurePopup(contentText:String, delay:int, marginTop:int=0):void
        {
            var params:Object = new Object();
            params.content = contentText;
            params.delay = (delay * 1000);
            params.marginTop = marginTop;
            if (this.uiApi.getUi("delayedclosurepopup"))
            {
                this.uiApi.unloadUi("delayedclosurepopup");
            };
            this.uiApi.loadUi("delayedclosurepopup", null, params, 3);
        }

        public function openLockedPopup(title:String, content:String, onCancel:Function=null, simpleBackground:Boolean=true, closeAtHook:Boolean=false, closeParam:Array=null, autoClose:Boolean=false, useHyperLink:Boolean=false):String
        {
            this._currentPopupNumber++;
            var params:Object = new Object();
            params.title = title;
            params.content = content;
            params.onCancel = onCancel;
            params.simpleBackground = simpleBackground;
            params.closeAtHook = closeAtHook;
            params.closeParam = ((!((closeParam == null))) ? closeParam : ["5000"]);
            params.autoClose = autoClose;
            params.useHyperLink = useHyperLink;
            params.hideModalContainer = (this._currentPopupNumber > 1);
            var popupName:String = ("popup" + ++this._popupId);
            this.uiApi.loadUi("lockedPopup", popupName, params, 3);
            return (popupName);
        }

        public function openQuantityPopup(min:Number, max:Number, defaultValue:Number, validCallback:Function, cancelCallback:Function=null, lockValue:Boolean=false):void
        {
            var params:Object = new Object();
            params.min = min;
            params.max = max;
            params.defaultValue = defaultValue;
            params.validCallback = validCallback;
            params.cancelCallback = cancelCallback;
            params.lockValue = lockValue;
            if (this.uiApi.getUi("quantityPopup"))
            {
                this.uiApi.unloadUi("quantityPopup");
            };
            this.uiApi.loadUi("quantityPopup", null, params, 3);
        }

        public function openInputPopup(title:String, content:String, validCallback:Function, cancelCallback:Function, defaultValue:String="", restric:String=null, maxChars:int=0):void
        {
            this._currentPopupNumber++;
            var params:Object = new Object();
            params.title = title;
            params.content = content;
            params.validCallBack = validCallback;
            params.cancelCallback = cancelCallback;
            params.defaultValue = defaultValue;
            params.restric = restric;
            params.maxChars = maxChars;
            params.hideModalContainer = (this._currentPopupNumber > 1);
            this.uiApi.loadUi("inputPopup", ("inputPopup" + this._popupId++), params, 3);
        }

        public function openInputComboBoxPopup(title:String, content:String, resetButtonTooltip:String, validCallback:Function, cancelCallback:Function, resetCallback:Function, defaultValue:String="", restric:String=null, maxChars:int=0, dataProvider:*=null):void
        {
            this._currentPopupNumber++;
            var params:Object = new Object();
            params.title = title;
            params.content = content;
            params.resetButtonTooltip = resetButtonTooltip;
            params.validCallBack = validCallback;
            params.cancelCallback = cancelCallback;
            params.resetCallback = resetCallback;
            params.defaultValue = defaultValue;
            params.restric = restric;
            params.maxChars = maxChars;
            params.hideModalContainer = (this._currentPopupNumber > 1);
            params.dataProvider = dataProvider;
            this.uiApi.loadUi("inputComboBoxPopup", ("inputComboBoxPopup" + this._popupId++), params, 3);
        }

        public function openCheckboxPopup(title:String, content:String, validCallback:Function, cancelCallback:Function, checkboxText:String, defaultSelect:Boolean=false):void
        {
            this._currentPopupNumber++;
            var params:Object = new Object();
            params.title = title;
            params.content = content;
            params.validCallBack = validCallback;
            params.cancelCallback = cancelCallback;
            params.checkboxText = checkboxText;
            params.defaultSelect = defaultSelect;
            params.hideModalContainer = (this._currentPopupNumber > 1);
            this.uiApi.loadUi("checkboxPopup", ("checkboxPopup" + this._popupId++), params, 3);
        }

        public function openPollPopup(title:String, content:String, answers:Array, onlyOneAnswer:Boolean, validCallback:Function, cancelCallback:Function):void
        {
            this._currentPopupNumber++;
            var params:Object = new Object();
            params.title = title;
            params.content = content;
            params.validCallBack = validCallback;
            params.cancelCallback = cancelCallback;
            params.answers = answers;
            params.onlyOneAnswer = onlyOneAnswer;
            params.hideModalContainer = (this._currentPopupNumber > 1);
            this.uiApi.loadUi("pollPopup", ("pollPopup" + this._popupId++), params, 3);
        }

        public function closeAllMenu():void
        {
            this.modMenu.closeAllMenu();
        }

        public function createContextMenu(menu:Array):void
        {
            this.modMenu.createContextMenu(menu);
        }

        public function createContextMenuTitleObject(label:String):Object
        {
            return (this.modMenu.createContextMenuTitleObject(label));
        }

        public function createContextMenuItemObject(label:String, callback:Function=null, callbackArgs:Array=null, disabled:Boolean=false, child:Array=null, selected:Boolean=false, radioStyle:Boolean=true, help:String=null, forceCloseOnSelect:Boolean=false):Object
        {
            return (this.modMenu.createContextMenuItemObject(label, callback, callbackArgs, disabled, child, selected, radioStyle, help, forceCloseOnSelect));
        }

        public function createContextMenuSeparatorObject():Object
        {
            return (this.modMenu.createContextMenuSeparatorObject());
        }

        public function openOptionMenu(close:Boolean=false, tab:String=null):void
        {
            if (((!(close)) && (!(this.uiApi.getUi("optionContainer")))))
            {
                this.uiApi.loadUi("optionContainer", null, tab, 3);
            };
            if (close)
            {
                this.uiApi.unloadUi("optionContainer");
            };
        }

        private function onToggleFullScreen(shortcut:String):Boolean
        {
            if (shortcut != "toggleFullscreen")
            {
                return (true);
            };
            var isFullScreen:Boolean = this.configApi.getConfigProperty("dofus", "fullScreen");
            if (((this.sysApi.isStreaming()) && (isFullScreen)))
            {
                this.uiApi.setShortcutUsedToExitFullScreen(true);
            };
            this.configApi.setConfigProperty("dofus", "fullScreen", !(isFullScreen));
            return (false);
        }

        private function onOpenWebPortal(page:uint, showBigClose:Boolean=false, args:Object=null):void
        {
            if (this.uiApi.getUi(UIEnum.WEB_PORTAL))
            {
                if (page == this._lastPage)
                {
                    Api.ui.unloadUi(UIEnum.WEB_PORTAL);
                }
                else
                {
                    Api.ui.getUi(UIEnum.WEB_PORTAL).uiClass.goTo(page, showBigClose, args);
                };
            }
            else
            {
                Api.ui.loadUi(UIEnum.WEB_PORTAL, UIEnum.WEB_PORTAL, [page, showBigClose, args], 2);
            };
            this._lastPage = page;
        }

        private function onOpenItemRecipes(item:Object):void
        {
            Api.ui.unloadUi("itemRecipes");
            Api.ui.loadUi("itemRecipes", "itemRecipes", {"item":item}, 2);
        }

        private function onOpenItemSet(item:Object):void
        {
            Api.ui.unloadUi("itemsSet");
            Api.ui.loadUi("itemsSet", "itemsSet", {"item":item}, 2);
        }

        private function onOpenFeed(item:Object):void
        {
            Api.ui.unloadUi("feedUi");
            Api.ui.loadUi("feedUi", "feedUi", {
                "item":item,
                "type":1
            }, 2);
        }

        private function onOpenMountFeed(mountId:int, location:int, foodList:Object):void
        {
            Api.ui.unloadUi("feedUi");
            Api.ui.loadUi("feedUi", "feedUi", {
                "type":3,
                "mountId":mountId,
                "mountLocation":location,
                "foodList":foodList
            }, 2);
        }

        private function onShowObjectLinked(item:Object=null):void
        {
            if (!(this.uiApi.getUi("itemBoxPopup")))
            {
                Api.ui.loadUi("itemBoxPopup", "itemBoxPopup", {"item":item});
            };
        }

        public function createItemBox(name:String, father:GraphicContainer, item:Object, showTheoretical:Boolean=false):Object
        {
            if (((!(item)) || ((item == null))))
            {
                Api.ui.unloadUi(name);
            }
            else
            {
                if (!(this.uiApi.getUi(name)))
                {
                    return (this.uiApi.loadUiInside("itemBox", father, name, {
                        "item":item,
                        "showTheoretical":showTheoretical
                    }));
                };
                if (this.uiApi.getUi(name).uiClass)
                {
                    this.uiApi.getUi(name).uiClass.onItemSelected(item, showTheoretical);
                };
            };
            return (null);
        }

        public function openPasswordMenu(size:int, changeOrUse:Boolean, onConfirm:Function, onCancel:Function=null):void
        {
            if (!(this.uiApi.getUi("passwordMenu")))
            {
                this.uiApi.loadUi("passwordMenu", "passwordMenu", {
                    "size":size,
                    "changeOrUse":changeOrUse,
                    "confirmCallBack":onConfirm,
                    "cancelCallBack":onCancel
                });
            };
        }

        public function createPaymentObject(paymentData:Object=null, disabled:Boolean=false, bonusNeeded:Boolean=true):Object
        {
            if (!(this.uiApi.getUi("payment")))
            {
                return (this.uiApi.loadUi("payment", "payment", {
                    "paymentData":paymentData,
                    "disabled":disabled,
                    "bonusNeeded":bonusNeeded
                }, 3));
            };
            return (null);
        }

        public function createRecipesObject(name:String, father:GraphicContainer, subRecipesCtr:Object, recipes:Object, maxSlots:int):Object
        {
            if (!(this.uiApi.getUi(name)))
            {
                return (this.uiApi.loadUiInside("recipes", father, name, {
                    "subRecipesCtr":subRecipesCtr,
                    "recipes":recipes,
                    "maxSlots":maxSlots
                }));
            };
            father.addContent(this.uiApi.getUi(name));
            return (this.uiApi.getUi(name));
        }

        public function onLoginQueueStatus(position:uint, total:uint):void
        {
            if (((!(this.uiApi.getUi("queuePopup"))) && ((position > 0))))
            {
                this.uiApi.loadUi("queuePopup", "queuePopup", [position, total, true], 3);
            };
        }

        public function onQueueStatus(position:uint, total:uint):void
        {
            if (((!(this.uiApi.getUi("queuePopup"))) && ((position > 0))))
            {
                this.uiApi.loadUi("queuePopup", "queuePopup", [position, total, false], 3);
            };
        }

        private function onSecureModeChange(active:Boolean):void
        {
            if (((active) && (!(this.uiApi.getUi("secureModeIcon")))))
            {
                this.uiApi.loadUi("secureModeIcon", "secureModeIcon", this._secureModeNeedReboot, StrataEnum.STRATA_HIGH);
                this.uiApi.loadUi("secureMode", "secureMode", this._secureModeNeedReboot, StrataEnum.STRATA_HIGH);
            };
            if (((!(active)) && (this.uiApi.getUi("secureModeIcon"))))
            {
                this.uiApi.unloadUi("secureModeIcon");
            };
        }

        public function unload():void
        {
            Api.system = null;
            Api.ui = null;
            Api.tooltip = null;
            Api.data = null;
        }

        public function openDownload(partId:int):void
        {
            if (!(this.uiApi.getUi("downloadUi")))
            {
                this.uiApi.loadUi("downloadUi", "downloadUi", {"partId":partId}, 2);
            };
        }

        public function onPartInfo(part:Object, installationPercent:Number):void
        {
            if (part.state == 1)
            {
                this.openDownload(part.id);
            };
        }

        public function onConnectionStart():void
        {
            if (((this.sysApi.isDownloadFinished()) && (!(this.uiApi.getUi("downloadUi")))))
            {
                this.uiApi.loadUi("downloadUi", "downloadUi", {"state":1}, 3);
            };
        }

        public function onGameStart():void
        {
            if (((this.sysApi.isDownloadFinished()) && (!(this.uiApi.getUi("downloadUi")))))
            {
                this.uiApi.loadUi("downloadUi", "downloadUi", {"state":1}, 3);
            };
            if (this.secureApi.SecureModeisActive())
            {
                this.uiApi.loadUi("secureModeIcon", "secureModeIcon", null, StrataEnum.STRATA_HIGH);
            };
        }


    }
}//package 

