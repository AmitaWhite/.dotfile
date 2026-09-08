-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- PDF 를 직접 열었을 때 페이지 넘기기: ]p 다음 / [p 이전 / gp 번호로 이동
--
-- snacks.image 에는 페이지 이동 키가 없다. 페이지는 src 경로 뒤 "#page=N" 으로 고르는 구조라
-- (snacks/image/convert.lua 의 get_page), 같은 버퍼에 src 만 바꿔 다시 attach 하면 페이지가 바뀐다.
-- 총 페이지 수는 ghostscript(gs) 가 있을 때만 구한다 (없으면 상한 없이 넘긴다).
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("my_pdf_pages", { clear = true }),
  pattern = "image",
  callback = function(ev)
    local buf = ev.buf
    local file = vim.api.nvim_buf_get_name(buf)
    if not file:lower():match("%.pdf$") then
      return
    end
    vim.b[buf].pdf_page = vim.b[buf].pdf_page or 1

    -- 재-attach 때마다 FileType 이 다시 불리므로, 페이지 수는 한 번만 센다
    if vim.b[buf].pdf_pages == nil and vim.fn.executable("gs") == 1 then
      vim.b[buf].pdf_pages = false -- 조회 중
      vim.system(
        { "gs", "-q", "-dNODISPLAY", "-dNOSAFER", "-c", ("(%s) (r) file runpdfbegin pdfpagecount = quit"):format(file) },
        { text = true },
        function(r)
          local n = tonumber((r.stdout or ""):match("%d+"))
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(buf) then
              vim.b[buf].pdf_pages = n or nil
            end
          end)
        end
      )
    end

    local function goto_page(page)
      local total = vim.b[buf].pdf_pages
      page = math.max(1, page)
      if type(total) == "number" and page > total then
        page = total
      end
      if page == vim.b[buf].pdf_page then
        return
      end
      vim.b[buf].pdf_page = page
      Snacks.image.buf.attach(buf, { src = file .. "#page=" .. page })
      vim.notify(
        ("PDF %d / %s"):format(page, type(total) == "number" and total or "?"),
        vim.log.levels.INFO,
        { title = "PDF" }
      )
    end

    local map = function(lhs, fn, desc)
      vim.keymap.set("n", lhs, fn, { buffer = buf, desc = desc })
    end
    map("]p", function()
      goto_page(vim.b[buf].pdf_page + 1)
    end, "PDF 다음 페이지")
    map("[p", function()
      goto_page(vim.b[buf].pdf_page - 1)
    end, "PDF 이전 페이지")
    map("gp", function()
      vim.ui.input({ prompt = "PDF 페이지: " }, function(s)
        local n = tonumber(s)
        if n then
          goto_page(n)
        end
      end)
    end, "PDF 페이지 번호로 이동")
  end,
})
