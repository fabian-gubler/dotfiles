/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int gappx     = 10;       /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 0;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int usealtbar          = 0;        /* 1 means use non-dwm status bar */
static const char *altbarclass      = "Polybar"; /* Alternate bar class name */
static const char *altbarcmd        = "$HOME/.config/polybar/launch.sh"; /* Alternate bar launch command */
static const int horizpadbar        = 0;        /* horizontal padding for statusbar */
static const int vertpadbar         = 3;        /* vertical padding for statusbar */
static const char *fonts[]          = { "SFMono:size=12" };
static const char col_gray1[]       = "#252A34";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#d8dee9";
static const char col_cyan[]        = "#5e81ac";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_gray1,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class            instance    title       tags mask     isfloating   monitor    scratch key */
	{ "Gimp",           NULL,       NULL,       0,            1,           -1,        0  },
	{ "Firefox",        NULL,       NULL,       1 << 8,       0,           -1,        0  },
	{ "gnome-pie",      NULL,       NULL,       1 << 8,       1,           -1,        0  },
	{ "firefox",        NULL,       NULL,       0,            0,           -1,       's' },
	{ "Mailspring",     NULL,       NULL,       0,            0,           -1,       'm' },
	{ "Typora",         NULL,       NULL,       0,            0,           -1,       't' },
	{ NULL,             NULL,       "scratch",  0,            0,           -1,       'r' },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 0; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><=",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};


/* key definitions */
#include <X11/XF86keysym.h>
#define MODKEY Mod4Mask
#define PrintScreen 0x0000ff61
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", NULL };
static const char *termcmd[] = { "alacritty", NULL };

/*First arg only serves to match against key in rules*/
static const char *firefoxscratch[] = {"s", "firefox", NULL}; 
static const char *mailscratch[] = {"m", "mailspring", NULL}; 
static const char *notescratch[] = {"t", "typora", NULL}; 
static const char *termscratch[] = {"r", "alacritty", "-t", "scratch", "-e", "tmuxdd", NULL}; 

#include "movestack.c"
static Key keys[] = {
	/* modifier                     key        function        argument */
  { MODKEY,                       XK_v,      spawn,          SHCMD("networkmanager_dmenu")},
  { MODKEY,                       XK_f,      spawn,          SHCMD("alacritty -e ranger")},
  { MODKEY|ShiftMask,             XK_f,      spawn,          SHCMD("pcmanfm")},
  { MODKEY,                       XK_k,      spawn,          SHCMD("$HOME/.dotfiles/scripts/dmenu/dmlogout")},
  { MODKEY,                       XK_j,      spawn,          SHCMD("$HOME/.dotfiles/scripts/dmenu/dmconf")},
  { MODKEY|ShiftMask,             XK_k,      spawn,          SHCMD("$HOME/.dotfiles/scripts/dmenu/dlay")},
  { MODKEY,                       XK_c,      spawn,          SHCMD("$HOME/.dotfiles/scripts/utils/colorpicker.sh")},
	{ MODKEY,                       XK_b,      spawn,          SHCMD("$HOME/.dotfiles/scripts/utils/dmenu-bluetooth")},
	{ MODKEY|ShiftMask,             XK_t,      spawn,          SHCMD("alacritty -e sc-im /data/drive/todo.sc")},
	{ MODKEY|ShiftMask,             XK_v,      spawn,          SHCMD("VBoxManage startvm 'Windows 10'")},
	{ MODKEY|ShiftMask,             XK_p,      spawn,          SHCMD("pavucontrol")},
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, togglescratch,  {.v = termscratch } },
	{ MODKEY,                       XK_w,      togglescratch,  {.v = firefoxscratch } },
	{ MODKEY,                       XK_g,      togglescratch,  {.v = mailscratch } },
	{ MODKEY,                       XK_a,      togglescratch,  {.v = notescratch } },
	{ MODKEY|ShiftMask,             XK_r,      spawn,          SHCMD("alacritty -e ytfzf -t --preview-side=right")},
	{ MODKEY,                       XK_s,      togglebar,      {0} },
  { MODKEY,                       XK_n,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_e,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_m,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_i,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_n,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_e,      movestack,      {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY|ControlMask,           XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_h,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY|ControlMask,           XK_l,      incnmaster,     {.i = +1 } },
	{ MODKEY|ControlMask,           XK_u,      incnmaster,     {.i = -1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
  { 0, XF86XK_AudioLowerVolume, spawn, SHCMD("$HOME/.dotfiles/system/rumno/mediactrl.sh volume-dec")},
	{ 0, XF86XK_AudioRaiseVolume, spawn, SHCMD("$HOME/.dotfiles/system/rumno/mediactrl.sh volume-inc")},
	{ 0, XF86XK_AudioMute, spawn, SHCMD("$HOME/.dotfiles/system/rumno/mediactrl.sh volume-toggle")},
  { 0, XF86XK_MonBrightnessUp, spawn, SHCMD("$HOME/.dotfiles/system/rumno/mediactrl.sh brightness-inc")},
	{ 0, XF86XK_MonBrightnessDown, spawn, SHCMD("$HOME/.dotfiles/system/rumno/mediactrl.sh brightness-dec")},
  { 0, PrintScreen,      spawn, SHCMD("flameshot gui")},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

static const char *ipcsockpath = "/tmp/dwm.sock";
static IPCCommand ipccommands[] = {
  IPCCOMMAND(  view,                1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  toggleview,          1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  tag,                 1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  toggletag,           1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  tagmon,              1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  focusmon,            1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  focusstack,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  zoom,                1,      {ARG_TYPE_NONE}   ),
  IPCCOMMAND(  incnmaster,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  killclient,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  togglefloating,      1,      {ARG_TYPE_NONE}   ),
  IPCCOMMAND(  setmfact,            1,      {ARG_TYPE_FLOAT}  ),
  IPCCOMMAND(  setlayoutsafe,       1,      {ARG_TYPE_PTR}    ),
  IPCCOMMAND(  quit,                1,      {ARG_TYPE_NONE}   )
};

