return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          {
            icon = ' ',
            key = 'f',
            desc = 'Find File',
            action = ":lua Snacks.dashboard.pick('files')",
          },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          {
            icon = ' ',
            key = 'g',
            desc = 'Find Text',
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = ' ',
            key = 'r',
            desc = 'Recent Files',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = ' ',
            key = 'c',
            desc = 'Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          {
            icon = '󰒲 ',
            key = 'L',
            desc = 'Lazy',
            action = ':Lazy',
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
        header = [[
                                                                                                                                                                           
  ÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆ                                                                                                                                                          
   ÆÆÆÆ         ÆÆÆÆÆÆ                 ÆÆÆÆÆÆÆÆÆ      ÆÆÆÆÆÆÆÆÆÆÆ     ÆÆÆÆÆÆÆÆÆÆÆÆ  ÆÆÆÆÆÆÆÆÆÆÆÆÆÆ ÆÆÆÆÆ      ÆÆÆÆ       ÆÆÆÆ    ÆÆÆÆÆ       ÆÆÆÆÆÆÆÆÆÆÆÆ    ÆÆÆÆÆÆÆÆÆÆÆÆ  
   ÆÆÆÆ             ÆÆÆÆ              ÆÆÆÆ  ÆÆÆÆ    ÆÆÆÆÆÆÆ ÆÆÆÆÆÆÆ   ÆÆÆÆÆÆÆÆÆÆÆÆ  ÆÆÆÆÆÆÆÆÆÆÆÆÆÆ  ÆÆÆÆ      ÆÆÆÆÆ     ÆÆÆÆ     ÆÆÆÆÆ        ÆÆÆÆÆÆÆÆÆÆÆÆÆ   ÆÆÆÆÆÆÆÆÆÆÆ  
   ÆÆÆÆ    ÆÆÆÆÆÆÆÆÆ ÆÆÆÆ ÆÆÆÆ       ÆÆÆÆ          ÆÆÆÆÆ       ÆÆÆÆÆ  ÆÆÆÆ               ÆÆÆÆ        ÆÆÆÆ    ÆÆÆÆÆÆ     ÆÆÆ     ÆÆÆÆÆÆÆ       ÆÆÆ      ÆÆÆÆ   ÆÆÆ          
   ÆÆÆÆ     ÆÆÆ       ÆÆÆ   ÆÆÆÆ      ÆÆÆÆÆÆ       ÆÆÆÆ         ÆÆÆÆ  ÆÆÆÆ               ÆÆÆÆ         ÆÆÆ   ÆÆÆÆ ÆÆÆ   ÆÆÆÆ    ÆÆÆÆ ÆÆÆÆ      ÆÆÆ      ÆÆÆ    ÆÆÆ     Æ    
   ÆÆÆÆ     ÆÆÆÆ     ÆÆÆÆ     ÆÆÆ       ÆÆÆÆÆÆÆÆ   ÆÆÆÆ         ÆÆÆÆ  ÆÆÆÆÆÆÆÆÆÆÆ        ÆÆÆÆ         ÆÆÆÆ  ÆÆÆ  ÆÆÆ  ÆÆÆÆ    ÆÆÆÆ   ÆÆÆ      ÆÆÆÆÆÆÆÆÆÆ      ÆÆÆÆÆÆÆÆÆ    
   ÆÆÆÆ     ÆÆÆÆ    ÆÆÆÆ      ÆÆÆÆ          ÆÆÆÆÆ  ÆÆÆÆ         ÆÆÆÆ  ÆÆÆÆÆÆÆÆÆÆÆ        ÆÆÆÆ          ÆÆÆÆÆÆÆÆ   ÆÆÆ ÆÆÆ     ÆÆÆ    ÆÆÆÆ     ÆÆÆ    ÆÆÆÆ     ÆÆÆ          
   ÆÆÆÆ     ÆÆ    ÆÆÆÆ        ÆÆÆÆ    Æ       ÆÆÆ  ÆÆÆÆÆ       ÆÆÆÆÆ  ÆÆÆÆ               ÆÆÆÆ           ÆÆÆÆÆÆ    ÆÆÆÆÆÆÆ    ÆÆÆÆÆÆÆÆÆÆÆÆÆ    ÆÆÆ     ÆÆÆÆ    ÆÆÆ          
   ÆÆÆÆ ÆÆÆÆÆÆÆÆÆÆÆ          ÆÆÆÆ    ÆÆÆÆÆ ÆÆÆÆÆÆ   ÆÆÆÆÆÆÆ ÆÆÆÆÆÆ    ÆÆÆÆ               ÆÆÆÆ           ÆÆÆÆÆ      ÆÆÆÆÆ    ÆÆÆÆ       ÆÆÆÆ   ÆÆÆ      ÆÆÆ    ÆÆÆÆÆÆÆÆÆÆÆ  
   ÆÆÆÆ          ÆÆÆ       ÆÆÆÆ       ÆÆÆÆÆÆÆÆÆ        ÆÆÆÆÆÆÆÆÆ      ÆÆÆÆ               ÆÆÆÆ            ÆÆÆÆ      ÆÆÆÆÆ   ÆÆÆÆÆ       ÆÆÆÆÆ ÆÆÆÆÆ     ÆÆÆÆ  ÆÆÆÆÆÆÆÆÆÆÆÆ  
   ÆÆÆÆ     ÆÆÆÆ   ÆÆÆ ÆÆÆÆÆ                                                                                                                                               
   ÆÆÆÆ     ÆÆÆÆÆÆ ÆÆÆÆ  ÆÆÆ                                                                                                                                               
   ÆÆÆÆ     ÆÆÆ     ÆÆÆÆ   ÆÆÆ        ÆÆÆÆÆÆ         ÆÆ           ÆÆÆÆÆ         ÆÆÆÆÆÆ        ÆÆÆÆÆ         ÆÆÆÆÆÆ        Æ    Æ                                           
   ÆÆÆÆ     ÆÆÆÆ     ÆÆÆ    ÆÆÆ       Æ              Æ Æ          Æ    Æ          Æ          Æ     Æ        Æ    Æ         Æ  ÆÆ                                           
    ÆÆÆ     ÆÆÆÆ     ÆÆÆÆ    ÆÆÆ      Æ             ÆÆ Æ          Æ               Æ          Æ     Æ        Æ    Æ         ÆÆ Æ                                            
  ÆÆÆÆÆÆÆ   ÆÆÆÆ    ÆÆÆÆÆÆÆ  ÆÆÆÆ     ÆÆÆÆÆ         Æ   Æ         Æ               Æ          Æ     Æ        Æ ÆÆÆ           ÆÆ                                             
            ÆÆÆÆ             ÆÆÆÆ     Æ            ÆÆÆÆÆÆ         Æ    Æ          Æ          Æ     Æ        Æ    Æ           Æ                                             
           ÆÆÆÆÆÆ            ÆÆÆÆÆÆ   ÆÆ           Æ     Æ        ÆÆÆÆÆÆ          Æ          ÆÆÆÆÆÆ         Æ    Æ          ÆÆ                                             
                                                                                                                                                                           
            ]],
      },
      sections = {
        { section = 'header' },
        { section = 'startup' },
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
