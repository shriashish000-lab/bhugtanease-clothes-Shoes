# Kapda & Shoes Billing Software

Clothes aur Footwear shop ke liye billing software — Login protected, Sale/Purchase bills,
Stock, Parties, Ledger, P&L Report, aur exact invoice format.

## EXE kaise milegi (GitHub Actions se automatic)

Is repo mein `.github/workflows/build-exe.yml` file already daali hui hai. Iska matlab
GitHub khud aapke liye Windows `.exe` file bana dega — aapko apne computer mein kuch bhi
install karne ki zarurat nahi.

### STEP-BY-STEP:

1. **Is poore folder ko apni GitHub repo mein push karo:**
   ```bash
   git init
   git add .
   git commit -m "Add billing software + auto exe build"
   git branch -M main
   git remote add origin https://github.com/shriashish000-lab/bhugtanease-clothes-Shoes.git
   git push -u origin main
   ```

2. **Push hote hi build automatic shuru ho jayegi.**
   Apni repo par jaake **"Actions"** tab kholo (upar wale menu mein) —
   wahan "Build Windows EXE" naam ki job chalti dikhegi (2-3 minute lagenge).

3. **Jab build "green tick ✅" ho jaye:**
   Usi run ke andar neeche **"Artifacts"** section mein
   `KapdaShoesBilling-exe` naam ki zip milegi — usse download karke
   extract karo, andar `KapdaShoesBilling.exe` hogi. Bas ye chalao.

4. **(Optional) Proper "Release" version chahiye ho** — matlab repo ke
   "Releases" page par direct download link ho — toh ek version tag
   push karo:
   ```bash
   git tag v1.0
   git push origin v1.0
   ```
   Isse automatic ek Release ban jayega jisme EXE seedha attach
   milegi (Artifacts jaisa 90-din expiry nahi hoga, permanent rahega).

## Manually apne PC par exe banani ho (GitHub ke bina)

```bash
pip install pyinstaller
pyinstaller --noconfirm --onefile --windowed --name "KapdaShoesBilling" kapda_shoes_billing.pyw
```
EXE `dist/KapdaShoesBilling.exe` mein milegi.

## Note

- Pehli baar EXE chalane par Windows SmartScreen warning de sakta hai
  (kyunki yeh unsigned naya program hai) — "More info" → "Run anyway"
  click karna.
- Database file EXE ke saath usi folder mein banegi jahan EXE rakhi ho.
