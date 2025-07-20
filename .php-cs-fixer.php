<?php

$finder = PhpCsFixer\Finder::create()
    ->in([
        __DIR__ . '/web/modules/custom',
        __DIR__ . '/web/themes/custom',
    ])
    ->name('*.php')
    ->ignoreDotFiles(true)
    ->ignoreVCS(true)
    ->exclude(['vendor', 'node_modules']);

return (new PhpCsFixer\Config())
    ->setRules([
        '@Drupal' => true,
    ])
    ->setFinder($finder);
