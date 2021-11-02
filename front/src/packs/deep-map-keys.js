import isObject from "lodash.isobject";

/**
 * deepMapKeys - 再帰関数でネストされたオブジェクトのキーを変換する
 *
 * @param  {Object} obj キーを変換したいオブジェクト
 * @param  {Object} cb キーを変換するコールバック
 * @return {Object}       変換済オブジェクト
 */
const deepMapKeys = (obj, cb) => {
  // base case (再帰ストップ)
  if (!isObject(obj) || obj instanceof File) {
    return obj;
  }

  if (Array.isArray(obj)) {
    // 配列ならキーの変換はなし
    return obj.map((val) => {
      // 再帰
      return deepMapKeys(val, cb);
    });
  }

  // オブジェクトならキーを変換
  // objectを[key, value]の配列に変換
  const entries = Object.entries(obj);
  // keyをcbに通し、valueを再帰的に処理
  const entries2 = entries.map(([key, value]) => [
    cb(value, key),
    deepMapKeys(value, cb),
  ]);
  // Object.formEntriesでobjectに戻す
  return Object.fromEntries(entries2);
};

export default deepMapKeys;
