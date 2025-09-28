{config, ...}: let
  profile =
    if config.hm.isWork
    then "pro"
    else "perso";
in {
  programs = {
    firefox = {
      profiles = {
        ${profile} = {
          extensions = {
            settings = {
              # Sidebery
              "{3c078156-979c-498b-8990-85f7987dd929}" = {
                force = true;
                settings = {
                  containers = let
                    containers = {
                      Personal = {
                        color = "green";
                        colorCode = "#7ccf00";
                        icon = "fingerprint";
                        urls = [
                          "romaindeville.fr"
                          "romaindeville.ovh"
                          "romaindeville.xyz"
                          "tekunix.cloud"
                          "localhost"
                        ];
                      };
                      Work = {
                        color = "orange";
                        colorCode = "#ff6900";
                        icon = "briefcase";
                        urls = [
                        ];
                      };
                      Bank = {
                        color = "purple";
                        colorCode = "#e12afb";
                        icon = "dollar";
                        urls = [
                          "cic.fr"
                        ];
                      };
                      Amazon = {
                        color = "red";
                        colorCode = "#fb2c36";
                        icon = "cart";
                        urls = [
                          "amazon.fr"
                          "amazon.com"
                        ];
                      };
                      LinkedIn = {
                        color = "blue";
                        colorCode = "#51a2ff";
                        icon = "briefcase";
                        urls = [
                          "linkedin.com"
                        ];
                      };
                      Github = {
                        color = "yellow";
                        colorCode = "#ffdf20";
                        icon = "chill";
                        urls = [
                          "github.com"
                        ];
                      };
                      Framagit = {
                        color = "yellow";
                        colorCode = "#f0b100";
                        icon = "chill";
                        urls = [
                          "framagit.org"
                        ];
                      };
                      Gitlab = {
                        color = "yellow";
                        colorCode = "#d08700";
                        icon = "chill";
                        urls = [
                          "gitlab.com"
                        ];
                      };
                      Google = {
                        color = "red";
                        colorCode = "#82181a";
                        icon = "vacation";
                        urls = [
                          "google.com"
                          "google.fr"
                        ];
                      };
                      DuckDuckGo = {
                        color = "red";
                        colorCode = "#82181a";
                        icon = "vacation";
                        urls = [
                          "duckduckgo.com"
                        ];
                      };
                      Wikis = {
                        color = "green";
                        colorCode = "#3c6300";
                        icon = "tree";
                        urls = [
                          "wikipedia.org"
                          "mynixos.com"
                          "home-manager-options.extranix.com"
                          "wiki.nixos.org"
                        ];
                      };
                      Mozilla = {
                        color = "green";
                        colorCode = "#192e03";
                        icon = "tree";
                        urls = [
                          "mozilla.org"
                        ];
                      };
                    };
                  in
                    builtins.foldl' (acc: elem: let
                      cfg = containers.${elem};
                    in
                      {
                        "${elem}" = {
                          inherit
                            (cfg)
                            color
                            colorCode
                            ;
                          id = elem;
                          cookieStoreId = elem;
                          name = elem;
                          icon =
                            if cfg?icon
                            then cfg.icon
                            else "circle";
                          reopenRulesActive = true;
                          reopenRules =
                            builtins.map (url: {
                              inherit url;
                              id = url;
                              active = true;
                              type = 1;
                            })
                            cfg.urls;
                        };
                      }
                      // acc) {} (builtins.attrNames containers);
                  settings = {
                    nativeScrollbars = true;
                    nativeScrollbarsThin = true;
                    nativeScrollbarsLeft = false;
                    selWinScreenshots = false;
                    updateSidebarTitle = true;
                    markWindow = false;
                    markWindowPreface = "[Sidebery] ";
                    ctxMenuNative = false;
                    ctxMenuRenderInact = true;
                    ctxMenuRenderIcons = true;
                    ctxMenuIgnoreContainers = "";
                    navBarLayout = "horizontal";
                    navBarInline = true;
                    navBarSide = "left";
                    hideAddBtn = false;
                    hideSettingsBtn = false;
                    navBtnCount = true;
                    hideEmptyPanels = true;
                    hideDiscardedTabPanels = false;
                    navActTabsPanelLeftClickAction = "none";
                    navActBookmarksPanelLeftClickAction = "none";
                    navTabsPanelMidClickAction = "discard";
                    navBookmarksPanelMidClickAction = "none";
                    navSwitchPanelsWheel = true;
                    subPanelRecentlyClosedBar = true;
                    subPanelBookmarks = true;
                    subPanelHistory = true;
                    subPanelSync = true;
                    groupLayout = "grid";
                    containersSortByName = true;
                    skipEmptyPanels = false;
                    dndTabAct = true;
                    dndTabActDelay = 750;
                    dndTabActMod = "none";
                    dndExp = "pointer";
                    dndExpDelay = 750;
                    dndExpMod = "none";
                    dndOutside = "win";
                    dndActTabFromLink = true;
                    dndActSearchTab = true;
                    dndMoveTabs = false;
                    dndMoveBookmarks = false;
                    searchBarMode = "dynamic";
                    searchPanelSwitch = "same_type";
                    searchBookmarksShortcut = "";
                    searchHistoryShortcut = "";
                    warnOnMultiTabClose = "collapsed";
                    activateLastTabOnPanelSwitching = true;
                    activateLastTabOnPanelSwitchingLoadedOnly = true;
                    switchPanelAfterSwitchingTab = "always";
                    tabRmBtn = "hover";
                    activateAfterClosing = "next";
                    activateAfterClosingStayInPanel = false;
                    activateAfterClosingGlobal = false;
                    activateAfterClosingNoFolded = true;
                    activateAfterClosingNoDiscarded = true;
                    askNewBookmarkPlace = true;
                    tabsRmUndoNote = true;
                    tabsUnreadMark = false;
                    tabsUpdateMark = "all";
                    tabsUpdateMarkFirst = true;
                    tabsReloadLimit = 5;
                    tabsReloadLimitNotif = true;
                    showNewTabBtns = true;
                    newTabBarPosition = "after_tabs";
                    tabsPanelSwitchActMove = false;
                    tabsPanelSwitchActMoveAuto = true;
                    tabsUrlInTooltip = "stripped";
                    newTabCtxReopen = false;
                    tabWarmupOnHover = true;
                    tabSwitchDelay = 0;
                    forceDiscard = true;
                    moveNewTabPin = "end";
                    moveNewTabParent = "last_child";
                    moveNewTabParentActPanel = false;
                    moveNewTab = "end";
                    moveNewTabActivePin = "start";
                    pinnedTabsPosition = "panel";
                    pinnedTabsList = false;
                    pinnedAutoGroup = false;
                    pinnedNoUnload = false;
                    pinnedForcedDiscard = false;
                    tabsTree = true;
                    groupOnOpen = true;
                    tabsTreeLimit = "none";
                    autoFoldTabs = false;
                    autoFoldTabsExcept = "none";
                    autoExpandTabs = false;
                    autoExpandTabsOnNew = false;
                    rmChildTabs = "folded";
                    tabsLvlDots = true;
                    discardFolded = true;
                    discardFoldedDelay = 15;
                    discardFoldedDelayUnit = "min";
                    tabsTreeBookmarks = true;
                    treeRmOutdent = "branch";
                    autoGroupOnClose = false;
                    autoGroupOnClose0Lvl = false;
                    autoGroupOnCloseMouseOnly = false;
                    ignoreFoldedParent = false;
                    showNewGroupConf = true;
                    sortGroupsFirst = true;
                    colorizeTabs = true;
                    colorizeTabsSrc = "container";
                    colorizeTabsBranches = false;
                    colorizeTabsBranchesSrc = "url";
                    inheritCustomColor = true;
                    previewTabs = false;
                    previewTabsMode = "p";
                    previewTabsPageModeFallback = "n";
                    previewTabsInlineHeight = 70;
                    previewTabsPopupWidth = 280;
                    previewTabsTitle = 2;
                    previewTabsUrl = 1;
                    previewTabsSide = "right";
                    previewTabsDelay = 500;
                    previewTabsFollowMouse = true;
                    previewTabsWinOffsetY = 36;
                    previewTabsWinOffsetX = 6;
                    previewTabsInPageOffsetY = 0;
                    previewTabsInPageOffsetX = 0;
                    previewTabsCropRight = 0;
                    hideInact = false;
                    hideFoldedTabs = false;
                    hideFoldedParent = "none";
                    nativeHighlight = true;
                    warnOnMultiBookmarkDelete = "collapsed";
                    autoCloseBookmarks = false;
                    autoRemoveOther = false;
                    highlightOpenBookmarks = false;
                    activateOpenBookmarkTab = false;
                    showBookmarkLen = true;
                    bookmarksRmUndoNote = true;
                    loadBookmarksOnDemand = true;
                    pinOpenedBookmarksFolder = true;
                    oldBookmarksAfterSave = "ask";
                    loadHistoryOnDemand = true;
                    fontSize = "s";
                    animations = true;
                    animationSpeed = "norm";
                    theme = "plain";
                    density = "compact";
                    colorScheme = "ff";
                    snapNotify = true;
                    snapExcludePrivate = true;
                    snapInterval = 0;
                    snapIntervalUnit = "min";
                    snapLimit = 0;
                    snapLimitUnit = "snap";
                    snapAutoExport = false;
                    snapAutoExportType = "json";
                    snapAutoExportPath = "Sidebery/snapshot-%Y.%M.%D-%h.%m.%s";
                    snapMdFullTree = false;
                    hScrollAction = "none";
                    onePanelSwitchPerScroll = false;
                    wheelAccumulationX = true;
                    wheelAccumulationY = true;
                    navSwitchPanelsDelay = 128;
                    scrollThroughTabs = "none";
                    scrollThroughVisibleTabs = true;
                    scrollThroughTabsSkipDiscarded = true;
                    scrollThroughTabsExceptOverflow = true;
                    scrollThroughTabsCyclic = false;
                    scrollThroughTabsScrollArea = 0;
                    autoMenuMultiSel = true;
                    multipleMiddleClose = false;
                    longClickDelay = 500;
                    wheelThreshold = false;
                    wheelThresholdX = 10;
                    wheelThresholdY = 60;
                    tabDoubleClick = "none";
                    tabsSecondClickActPrev = false;
                    tabsSecondClickActPrevPanelOnly = false;
                    tabsSecondClickActPrevNoUnload = false;
                    shiftSelAct = true;
                    activateOnMouseUp = false;
                    tabLongLeftClick = "none";
                    tabLongRightClick = "none";
                    tabMiddleClick = "close";
                    tabPinnedMiddleClick = "discard";
                    tabMiddleClickCtrl = "discard";
                    tabMiddleClickShift = "duplicate";
                    tabCloseMiddleClick = "close";
                    tabsPanelLeftClickAction = "none";
                    tabsPanelDoubleClickAction = "tab";
                    tabsPanelRightClickAction = "menu";
                    tabsPanelMiddleClickAction = "tab";
                    newTabMiddleClickAction = "new_child";
                    bookmarksLeftClickAction = "open_in_act";
                    bookmarksLeftClickActivate = false;
                    bookmarksLeftClickPos = "default";
                    bookmarksMidClickAction = "open_in_new";
                    bookmarksMidClickActivate = false;
                    bookmarksMidClickRemove = false;
                    bookmarksMidClickPos = "default";
                    historyLeftClickAction = "open_in_act";
                    historyLeftClickActivate = false;
                    historyLeftClickPos = "default";
                    historyMidClickAction = "open_in_new";
                    historyMidClickActivate = false;
                    historyMidClickPos = "default";
                    syncName = "Rey's Sideberry ";
                    syncUseFirefox = true;
                    syncUseGoogleDrive = false;
                    syncUseGoogleDriveApi = false;
                    syncUseGoogleDriveApiClientId = "";
                    syncSaveSettings = true;
                    syncSaveCtxMenu = true;
                    syncSaveStyles = true;
                    syncSaveKeybindings = true;
                    selectActiveTabFirst = true;
                    selectCyclic = false;
                  };
                  keybindings = {
                    _execute_sidebar_action = "Alt+E";
                    next_panel = "Alt+Shift+N";
                    prev_panel = "Alt+Shift+P";
                    new_tab_in_group = "Alt+Space";
                    unload_other_tabs_in_panel = "Alt+U";
                    switch_to_next_tab = "Alt+Shift+K";
                    switch_to_prev_tab = "Alt+Shift+J";
                  };
                  sidebarCSS = ''
                  #root.root {
                    --ntb-border-radius: 0px;
                    --search-border-radius: 0px;
                    --slt-margin: 0px;
                    --slt-border-radius: 0px;
                    --tabs-margin: 0px;
                    --tabs-border-radius: 0px;
                    --tabs-color-layer-opacity: 0.125;
                    --tabs-activated-color-layer-opacity: 0.25;
                    --tabs-discarded-favicon-opacity: 0.25;
                    --tabs-discarded-title-opacity: 0.5;
                    --tabs-indent: 12px;
                    --tabs-lvl-opacity: 0;
                    --nav-btn-margin: 0px;
                    --nav-btn-border-radius: 0px;
                    --general-margin: 0px;
                    --general-border-radius: 0px;
                  }
                  '';
                };
              };
            };
          };
        };
      };
    };
  };
}
